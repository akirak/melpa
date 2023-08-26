{
  inputs = {
    systems.url = "github:nix-systems/default";
    recipes-updater.url = "github:emacs-twist/recipes-updater";
  };

  outputs = {
    systems,
    nixpkgs,
    ...
  } @ inputs: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = eachSystem (system: {
      update-recipes = inputs.recipes-updater.packages.${system}.default.override {
        force = true;
      };
    });
  };
}
