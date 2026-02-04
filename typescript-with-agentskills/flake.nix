{
  description = "flake for Go with Agent-skills";

  inputs = {
    nixpkgs = {
      url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, agent-skills, anthropic-skills, ... }:
  flake-utils.lib.eachDefaultSystm (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      agentLib = agent-skills.lib.agent-skills;
      sources = {
        anthropic = {
          path = anthropic-skills;
          subdir = "skills";
        };
      };
      catalog = agentLib.discoverCatalog sources;
      allowlist = agentLib.allowlistFor {
        inherit catalog sources;
        # Add Agent Skills
        enable = [
          # "doc-coauthoring"
        ];
      };
      selection = agentLib.selectSkills {
        inherit catalog allowlist sources;
        skills = { };
      };
      bundle = agentLib.mkBundle { inherit pkgs selection; };
    in
    {
      apps.${system} = {
        skills-install-local = {
          type = "app";
          program = "${agentLib.mkLocalInstallScript {inherit pkgs bundle; }}/bin/skills-install-local";
        };
      };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs
          pnpm
        ];
      };
    }
  );
}
