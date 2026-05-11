# homebrew-tap

Homebrew tap for [Lenny Labs](https://github.com/lennylabs) projects. One formula per project; each project's release workflow keeps its own formula current.

## Use

```sh
brew tap lennylabs/tap
brew install <package>
```

`brew upgrade <package>` (or `brew upgrade` with no args) picks up new versions as each project's release workflow updates the corresponding formula.

## Available formulas

| Formula | Project | Description |
|:--|:--|:--|
| `podium` | [lennylabs/podium](https://github.com/lennylabs/podium) | Catalog and registry for reusable AI agent artifacts |

Add a row to this table when you add a new formula.

## Layout

```
Formula/
├── podium.rb
└── <future>.rb        ← drop a new formula here for each new project
```

Each formula is independent. Adding `Formula/foo.rb` doesn't touch any other formula in the tap.

## How formulas stay current

Each project's release workflow updates **only its own formula** in this repo. The pattern, by convention:

1. After a tag push, the project's release workflow downloads its just-released binaries from its own GitHub Release.
2. Computes SHA256 hashes per platform.
3. Clones this repo using a fine-grained PAT (`TAP_BUCKET_TOKEN` or similar) that has write access scoped to this single repo.
4. Patches `Formula/<project>.rb` (sed against the version field + sentinel-commented sha256 lines).
5. Commits and pushes.

The reference implementation lives in [lennylabs/podium's `.github/workflows/release.yml`](https://github.com/lennylabs/podium/blob/main/.github/workflows/release.yml) — copy and adapt the `publish-tap-bucket` job for any new project that wants to ship through this tap.

## Adding a new project

1. Drop `Formula/<project>.rb` here as a one-off commit (initially with placeholder SHA256s).
2. Add a row to the table above.
3. In the new project's repo, add the `TAP_BUCKET_TOKEN` secret (write access to this repo).
4. Adapt the `publish-tap-bucket` job from podium's release workflow — change the formula filename, the artifact filenames, and the sentinel comments. Everything else stays the same.

## Updating a formula by hand

```sh
PROJECT=podium
VERSION=X.Y.Z
for arch in darwin-arm64 linux-amd64 linux-arm64; do
  curl -sSL "https://github.com/lennylabs/${PROJECT}/releases/download/v${VERSION}/${PROJECT}-${arch}" \
    -o /tmp/${PROJECT}-${arch}
  echo "${arch}: $(sha256sum /tmp/${PROJECT}-${arch} | awk '{print $1}')"
done
# Edit Formula/${PROJECT}.rb: update version + each sha256
```

## License

[MIT](LICENSE).
