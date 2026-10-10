cask "codeloupe" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "ff1b8c2c3a69b7eb907185d58fd56e6d6cbec79a90a0a5c52f502ee300a76721",
         intel: "c71698efd3ff4252fe859bb4e052a809d8c1afc8ff49d11f82574c9988b3e106"

  url "https://github.com/Terrio-cz/CodeLoupe/releases/download/v#{version}/CodeLoupe-#{version}-mac-#{arch}.dmg"
  name "CodeLoupe"
  desc "On-demand code index for AI coding agents"
  homepage "https://github.com/Terrio-cz/CodeLoupe"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "CodeLoupe.app"
  binary "#{appdir}/CodeLoupe.app/Contents/Resources/codeloupe/bin/codeloupe"

  # The app is signed ad hoc, not notarised: without this Gatekeeper asks for a manual allow on the first start.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/CodeLoupe.app"]
  end

  zap trash: [
    "~/Library/Application Support/codeloupe-desktop",
    "~/Library/Caches/codeloupe",
    "~/Library/Preferences/cz.terrio.codeloupe.plist",
    "~/Library/Saved Application State/cz.terrio.codeloupe.savedState",
  ]
end
