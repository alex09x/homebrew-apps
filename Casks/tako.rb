cask "tako" do
  version "0.1.6"
  sha256 "2914a78fd90b0df32b2dd76043d160bd208c6ca91ab3fd6c822cd0fcfc3abfb9"

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
end
