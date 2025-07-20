{
  description = "A beginner-friendly NixOS flake featuring both minimal and modular configurations, ideal for quick setup or advanced customization.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = {nixpkgs, ...}: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    templates = {
      minimal = {
        description = ''
          A minimal Nix flake template — includes only essential configuration files.
          Great for users migrating from traditional Nix setups or starting with a clean, simple config.
        '';
        path = ./minimal;
      };
      standard = {
        description = ''
          A standard flake template — includes boilerplate for custom packages, overlays, and reusable modules.
          Ideal for those looking to build a more extensible and modular NixOS configuration.
        '';
        path = ./standard;
      };
    };
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
