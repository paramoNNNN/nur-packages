{
  description = "AI-authored NUR packaging for the AI-modified Textamp fork";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    {
      packages = nixpkgs.lib.genAttrs systems (
        system:
        let
          packages = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        in
        packages // { default = packages.textamp; }
      );
    };
}
