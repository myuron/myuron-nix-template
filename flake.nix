{
  description = "Collection of Nix flake templates for various programming languages";

  outputs = { self }: {
    templates = {
      go-with-agentskills = {
        path = ./go-with-agentskills;
        description = "Go development environment with agent-skills";
      };
    };
  };
}
