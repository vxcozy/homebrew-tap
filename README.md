# homebrew-tap

Homebrew tap for [vxcozy](https://github.com/vxcozy) projects.

## Install

Tap it once, then install normally:

```sh
brew tap vxcozy/tap
brew install clitunes
```

Or one-liner:

```sh
brew install vxcozy/tap/clitunes
```

## Available formulas

| Formula | Description |
|---------|-------------|
| [clitunes](Formula/clitunes.rb) | Terminal music player with internet radio, Spotify, and real-time visualisers. Upstream: [vxcozy/clitunes](https://github.com/vxcozy/clitunes) |

## Trust

This tap is maintained by a single person. Releases are published from the
upstream project's GitHub release workflow. Each formula pins the specific
SHA-256 of the release tarballs — `brew install` will refuse to proceed if
a downloaded tarball does not match the pinned hash.

The `main` branch has branch protection enabled: formula changes require a
pull request and cannot be force-pushed or deleted. The account has hardware
2FA enabled.

If you want stronger guarantees than a personal tap provides, build from
source: `cargo install --git https://github.com/vxcozy/clitunes --tag v1.0.0 --locked`.

## License

[MIT](LICENSE). Formulas in this tap install binaries published under the
upstream project's own license (MIT for clitunes).
