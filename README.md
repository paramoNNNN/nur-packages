# NUR packages

This packaging was fully written by AI. The packaged [terminal-music-player](https://github.com/paramoNNNN/terminal-music-player) fork is fully modified by AI. Original application: [bergmayer/textamp](https://github.com/bergmayer/textamp), by John Bergmayer.

The Nix packaging in this repository uses the MIT license. Textamp retains its Unlicense, recorded in `meta.license`.

After the NUR registration is merged and indexed:

```nix
home.packages = [ pkgs.nur.repos.paramoNNNN.textamp ];
```

Without NUR:

```sh
nix run github:paramoNNNN/nur-packages#textamp
```

The package fetches a pinned public source revision and vendors dependencies from the accompanying Cargo.lock. Supported platforms: Apple Silicon macOS and x86_64/ARM64 Linux.

For CI's exact cached package, use the application flake directly. NUR's Nixpkgs can differ from the application flake's pin, so a NUR build may require compilation. The application's public cache is https://terminal-music-player.cachix.org.
