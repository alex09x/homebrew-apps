# Source of truth for Formula/xref.rb in the alex09x/homebrew-apps tap.
# XRef — Ultra blazing fast binary analysis
# Copyright (c) 2026 Alexander Panasenko
# Contact: alex@prod.codes
# Author: https://prod.codes/about/
# Project: https://github.com/alex09x/xref
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Rendered and pushed to the tap by .github/workflows/update-homebrew.yml from the published
# prebuilt macOS Apple Silicon and Linux x86_64 release archives. Never builds
# from source, declares no Rust dependency, and never invokes cargo.
class Xref < Formula
  desc "Ultra blazing fast x86-64 ELF/Mach-O analysis, pseudo-C and live inspection"
  homepage "https://xrefcode.com"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/alex09x/xref/releases/download/v0.5.0/xref-v0.5.0-aarch64-apple-darwin.tar.gz"
    sha256 "ef998847585346e6b8e9d3278074eb31266a837116b7cdd80eea3e2b7e34dc58"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/alex09x/xref/releases/download/v0.5.0/xref-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "95bb82394f95f51a83f4be45ebdb43647d82a65fe4c16bc30ccb0a8ea8612624"
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
