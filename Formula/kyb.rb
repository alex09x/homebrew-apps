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
    user_name = [ENV["USER"], ENV["LOGNAME"]].find do |candidate|
      candidate && !candidate.strip.empty?
    end
    home = user_name ? Pathname.new("/Users") / user_name.strip : Pathname.new("/Users/runner")

    (home/".local/bin").mkpath
    cp opt_bin/"kyb", home/".local/bin/kyb"
    [".claude/skills/kyb", ".codex/skills/kyb", ".gemini/config/skills/kyb"].each do |relative_path|
      target = home/relative_path
      target.mkpath
      cp pkgshare/"skills/kyb/SKILL.md", target/"SKILL.md"
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
