# homebrew-tap

Homebrew casks by Ankesh Kumar.

## AI Notch

Claude Code and Cursor agent sessions in the MacBook notch. Source and docs:
[github.com/ankeshshankar/ai-notch](https://github.com/ankeshshankar/ai-notch).

```sh
brew install --cask ankeshshankar/tap/ai-notch
```

The app is signed ad hoc and not notarized, so macOS blocks its first open. Open it once from
Applications, then go to System Settings → Privacy & Security and click **Open Anyway** (the
button stays for about an hour after the attempt), and confirm with your login password.

```sh
brew uninstall --cask ai-notch          # takes AI Notch's hooks out, removes the app
brew uninstall --cask --zap ai-notch    # also deletes ~/.claude/notch (usage history)
```
