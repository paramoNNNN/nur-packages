{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  alsa-lib,
  python3,
  stdenv,
}:
rustPlatform.buildRustPackage {
  pname = "textamp";
  version = "1.0.0-mvp";
  src = fetchFromGitHub {
    owner = "paramoNNNN";
    repo = "terminal-music-player";
    rev = "8393df7babceb7cb310f6d1b0754ebf194ec3500";
    hash = "sha256-u5rwAenekb2HGZp1Bo3PMvf6FmZYK3upCDhzCdYKZs8=";
  };
  cargoLock.lockFile = ./Cargo.lock;
  # Test the full suite without applying release LTO to every test binary.
  checkType = "debug";
  env = {
    CARGO_INCREMENTAL = "0";
    CARGO_PROFILE_DEV_DEBUG = "0";
    CARGO_PROFILE_TEST_DEBUG = "0";
    CARGO_PROFILE_DEV_STRIP = "symbols";
    CARGO_PROFILE_TEST_STRIP = "symbols";
  };
  nativeBuildInputs = [ pkg-config ];
  nativeCheckInputs = [ python3 ];
  buildInputs = [
    openssl
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [ alsa-lib ];
  preCheck = ''
    export XDG_CONFIG_HOME="$TMPDIR/textamp-tests/config"
    export XDG_DATA_HOME="$TMPDIR/textamp-tests/data"
    export XDG_CACHE_HOME="$TMPDIR/textamp-tests/cache"
    export XDG_STATE_HOME="$TMPDIR/textamp-tests/state"
    mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME"
  '';
  meta = {
    description = "Terminal music player for Navidrome, Subsonic, WebDAV and local files";
    homepage = "https://github.com/paramoNNNN/terminal-music-player";
    license = lib.licenses.unlicense;
    mainProgram = "textamp";
    sourceProvenance = [ lib.sourceTypes.fromSource ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
