{
  description = "myuron nix templates";

  inputs = {
    nixpkg = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs =
    { nixpkgs, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = with pkgs; pkgs.mkShell {
          buildInputs = [
            nixpkgs-fmt
          ];
        };
      }) // {
      templates =
        let
          list = map
            ({ path, ... }@value: {
              inherit value;
              name = baseNameOf path;
            })
            [
              {
                path = ./go-with-agentskills;
                description = "go with agent-skills flake";
              }
            ];
        in
        builtins.listToAttrs list;
    };
}
