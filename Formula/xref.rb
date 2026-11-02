# Source of truth for Formula/xref.rb in the alex09x/homebrew-apps tap.
#
# Rendered by .github/workflows/update-homebrew.yml against the published
# prebuilt macOS Apple Silicon and Linux x86_64 release archives. Never builds
# from source, declares no Rust dependency, and never invokes cargo.
class Xref < Formula
  desc "Ultra blazing fast x86-64 ELF cross-references and structured pseudo-C"
  homepage "https://xrefcode.com"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/alex09x/xref/releases/download/v0.1.0/xref-v0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "9652793f0ee814c9dc212c54739b0e1b6bfc1f9ab30ef6c3fe4af65a805858b0"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/alex09x/xref/releases/download/v0.1.0/xref-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "30a6ac3303bfe86e4f23de10b5382bd56fb65df605c3e4cbced495e15e9d77de"
  end

  def install
    bin.install "xref"
    doc.install "README.md", "CITATION.cff"
    prefix.install "LICENSE-MIT", "LICENSE-APACHE"
  end

  test do
    assert_match "xref #{version}", shell_output("#{bin}/xref --version")
  end
end
