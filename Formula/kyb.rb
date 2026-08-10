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

    service_wrapper = libexec/"kyb-service"
    service_wrapper.write <<~SH
      #!/bin/bash
      set -euo pipefail
      for agent_dir in "$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.gemini/config/skills"; do
        /bin/mkdir -p "$agent_dir"
      done
      KYB_INSTALL_BINARY="#{opt_bin}/kyb" /bin/bash "#{pkgshare}/skills/install.sh"
      exec "#{opt_bin}/kyb-server"
    SH
    service_wrapper.chmod(0755)
  end

  post_install_steps do
    mkdir_p "kyb/data", base: :var
    mkdir_p "kyb/index", base: :var
    mkdir_p "log", base: :var
  end

  service do
    run [opt_libexec/"kyb-service"]
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
