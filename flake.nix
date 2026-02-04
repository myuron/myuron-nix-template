{
  description = "Collection of Nix flake templates for various programming languages";

  outputs = { self }: {
    templates = {
      go = {
        path = ./go;
        description = "Go development environment";
      };
      go-with-agentskills = {
        path = ./go-with-agentskills;
        description = "Go development environment with agent-skills";
      };
      typescript = {
        path = ./typescript;
        description = "typescript development";
      };
      typescript-with-agentskills = {
        path = ./typescript-with-agentskills;
        description = "typescript development environment with agent-skills";
      };
    };
  };
}
