cask "ai-notch" do
  version "0.2.0"
  sha256 "8a3883c19c69d0adcb52defffe18d80a26a477db1522951c8d829f68ef106414"

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
end
