cask "tako" do
  version "0.1.2"
  sha256 "9964a3970912ed159856d8312457364502cd22b7e71c423e446f7d834d994236"

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

  zap trash: [
    "~/.config/tako",
    "~/Library/Application Support/com.tako-core.terminal",
    "~/Library/Preferences/com.tako-core.terminal.plist",
    "~/Library/Saved Application State/com.tako-core.terminal.savedState",
  ]
end
