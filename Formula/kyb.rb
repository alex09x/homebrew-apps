class Kyb < Formula
  desc "Shared memory and incident tracker for AI agent fleet"
  homepage "https://github.com/alex09x/kyb"
  url "https://github.com/alex09x/kyb/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ebbd59bc3ec79db8f961e9d080ab4a70205ab4249dcd9a5601a1d9a8718373a2"
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
    [".claude/skills", ".codex/skills", ".gemini/config/skills"].each do |relative_path|
      (Pathname.new(Dir.home) / relative_path).mkpath
    end
    system({ "KYB_INSTALL_BINARY" => (opt_bin/"kyb").to_s }, "bash", (pkgshare/"skills/install.sh").to_s)
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
