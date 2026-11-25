cask "tako" do
  version "0.2.1"
  sha256 "7b44c5e545f779994430b44a214cc7d2bcd924b65984fb32ece2cb575db7f6fe"

  url "https://github.com/alex09x/tako/releases/download/v#{version}/Tako-#{version}.dmg"
  name "Tako"
  desc "Fast, lightweight terminal engine with native macOS Metal renderer"
  homepage "https://takocore.com"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Tako.app"
  binary "#{appdir}/Tako.app/Contents/MacOS/Tako", target: "tako"
  binary "#{appdir}/Tako.app/Contents/MacOS/takoctl", target: "takoctl"

  zap trash: [
    "~/.config/tako",
    "~/Library/Application Support/com.tako-core.terminal",
    "~/Library/Preferences/com.tako-core.terminal.plist",
    "~/Library/Saved Application State/com.tako-core.terminal.savedState",
  ]

  caveats <<~EOS
    Open Tako.app once and click Open if macOS asks for confirmation.
    Wait for a Tako window before running takoctl. Until you approve the
    first launch, takoctl can wait silently.
  EOS
end
