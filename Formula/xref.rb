# Source of truth for Formula/xref.rb in the alex09x/homebrew-apps tap.
# XRef Code — Ultra blazing fast binary analysis
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
  desc "Ultra blazing fast x86-64 ELF/Mach-O analysis and pseudo-C"
  homepage "https://xrefcode.com"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/alex09x/xref/releases/download/v0.2.0/xref-v0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "d90727a8a77a75f44cbb3febac23b2a2c7fb313422ba6808be03446545150e40"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/alex09x/xref/releases/download/v0.2.0/xref-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d8b70fac72e38c691504ab23db8829c41d2a89c210d6c67532efed96d2038f57"
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
