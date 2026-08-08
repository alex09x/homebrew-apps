class Kyb < Formula
  desc "Shared memory and incident tracker for AI agent fleet"
  homepage "https://github.com/alex09x/kyb"
  url "https://github.com/alex09x/kyb/archive/refs/tags/v0.1.2.tar.gz"
  head "https://github.com/alex09x/kyb.git", branch: "main"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"kyb"]
    keep_alive true
    working_dir var
    log_path var/"log/kyb.log"
    error_log_path var/"log/kyb.log"
  end

  test do
    assert_match "kyb", shell_output("#{bin}/kyb --help")
  end
end
