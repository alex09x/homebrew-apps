class Kyb < Formula
  desc "Shared memory and incident tracker for AI agent fleet"
  homepage "https://github.com/alex09x/kyb"
  url "https://github.com/alex09x/kyb/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "af0a21e76158eab767c9c42016d2028dcf5e9977da6c755a2180c930492f6590"
  license "MIT"
  head "https://github.com/alex09x/kyb.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    cli_copy = buildpath/"kyb-cli"
    cp "skills/kyb/bin/kyb", cli_copy
    pkgshare.install "skills" if File.exist?("skills")
    bin.install cli_copy => "kyb"
  end

  def post_install
    (var/"kyb/data").mkpath
    (var/"kyb/index").mkpath
    (var/"log").mkpath
    user_name = [ENV["USER"], ENV["LOGNAME"], "runner"].find do |candidate|
      candidate && !candidate.strip.empty?
    end
    home = Pathname.new("/Users") / user_name
    [".claude/skills", ".codex/skills", ".gemini/config/skills"].each do |relative_path|
      (home / relative_path).mkpath
    end
    installer = (pkgshare/"skills/install.sh").to_s
    installer_log = (var/"log/kyb-postinstall.log").to_s
    installer_env = { "KYB_INSTALL_BINARY" => (opt_bin/"kyb").to_s, "HOME" => home.to_s }
    unless Kernel.system(installer_env, "/bin/bash", installer,
                         out: installer_log, err: [:child, :out])
      odie "kyb skill installer failed; see #{installer_log}: #{File.read(installer_log)}"
    end
  end

  service do
    run [opt_bin/"kyb-server"]
    keep_alive true
    working_dir var/"kyb"
    log_path var/"log/kyb.log"
    error_log_path var/"log/kyb.log"
    environment_variables KYB_DATA: var/"kyb/data", KYB_INDEX: var/"kyb/index", KYB_ADDR: "127.0.0.1:9310"
  end

  test do
    assert_match "kyb", shell_output("#{bin}/kyb --help")
  end
end
