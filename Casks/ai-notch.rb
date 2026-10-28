cask "ai-notch" do
  version "0.6.3"
  sha256 "80d6e74d2c31823b0dfdc35cc70620b03164e7dcdb9f41d6ac17a42f302c3218"

  url "https://github.com/ankeshshankar/ai-notch/releases/download/v#{version}/AI-Notch-#{version}.dmg"
  name "AI Notch"
  desc "Claude Code and Cursor agent sessions in the MacBook notch"
  homepage "https://github.com/ankeshshankar/ai-notch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "AINotch.app"

  # Takes AI Notch's hooks out of ~/.claude/settings.json and ~/.cursor/hooks.json (a backup of
  # each changed file first); with no hooks it writes nothing. A copy that was never opened is
  # still quarantined, so macOS will not run it: it has set up no hooks, and the uninstall goes on.
  uninstall_preflight_steps do
    run "AINotch.app/Contents/MacOS/AINotch",
        args:           ["--setup-cli", "disconnect"],
        base:           :appdir,
        must_succeed:   false,
        writable_paths: [".claude", ".cursor"],
        writable_base:  :home
  end

  uninstall launchctl: "info.ankeshshiv.notch",
            quit:      "info.ankeshshiv.notch"

  zap trash: [
    "~/.claude/notch",
    "~/Library/LaunchAgents/info.ankeshshiv.notch.plist",
    "~/Library/Preferences/info.ankeshshiv.notch.plist",
  ]

  caveats <<~EOS
    AI Notch is signed ad hoc and not notarized, so macOS blocks its first open:
      1. Open AI Notch, click Done, then in System Settings > Privacy & Security
         click Open Anyway next to the message about AI Notch.
      2. If its setup window then says macOS is blocking AI Notch's helper, run
         the command it shows in Terminal and click Check Again:
           xattr -dr com.apple.quarantine "#{appdir}/AINotch.app"
  EOS
end
