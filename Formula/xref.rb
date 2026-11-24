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
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/alex09x/xref/releases/download/v0.6.0/xref-v0.6.0-aarch64-apple-darwin.tar.gz"
    sha256 "67749ee4ed7e6f41da56c79b9017bb86a69b216507a7d5cfc906701892e205d3"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/alex09x/xref/releases/download/v0.6.0/xref-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b35c29354b00421f729ee368356b1df1b5a20b99fdfb003a2ceac560cb9dfa45"
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
