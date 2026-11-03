# Source of truth for Formula/xref.rb in the alex09x/homebrew-apps tap.
# XRef — Ultra blazing fast binary analysis
# Copyright (c) 2026 Alexander Panasenko
# Contact: alex@prod.codes
# Author: https://prod.codes/about/
# Project: https://github.com/alex09x/xref
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Rendered by .github/workflows/update-homebrew.yml against the published
# prebuilt macOS Apple Silicon and Linux x86_64 release archives. Never builds
# from source, declares no Rust dependency, and never invokes cargo.
class Xref < Formula
  desc "Ultra blazing fast x86-64 ELF/Mach-O analysis, pseudo-C and live inspection"
  homepage "https://xrefcode.com"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/alex09x/xref/releases/download/v0.3.0/xref-v0.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "db7424d9d145a5e28426f4b28d1c55740bfa4a439e4bbf82ae25245892e641b5"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/alex09x/xref/releases/download/v0.3.0/xref-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9ecb7582f9a249b51deedfc01670daa1f3c62280428a2dc62787b9a05b75d5e3"
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
