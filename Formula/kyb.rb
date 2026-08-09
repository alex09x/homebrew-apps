class Kyb < Formula
  desc "Shared memory and incident tracker for AI agent fleet"
  homepage "https://github.com/alex09x/kyb"
  url "https://github.com/alex09x/kyb/archive/refs/tags/v0.1.2.tar.gz"
  head "https://github.com/alex09x/kyb.git", branch: "main"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    pkgshare.install "skills"
  end

  def post_install
    (var/"kyb/data").mkpath
    (var/"kyb/index").mkpath
    system({"KYB_INSTALL_BINARY" => opt_bin/"kyb"}, pkgshare/"skills/install.sh")
  end

  service do
    run [opt_bin/"kyb"]
    keep_alive true
    working_dir var
    log_path var/"log/kyb.log"
    error_log_path var/"log/kyb.log"
    environment_variables KYB_DATA: var/"kyb/data", KYB_INDEX: var/"kyb/index", KYB_ADDR: "127.0.0.1:9310"
  end

  test do
    assert_match "kyb", shell_output("#{bin}/kyb --help")
  end
end
