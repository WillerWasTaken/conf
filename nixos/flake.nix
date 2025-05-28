{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systemConfiguration = {
        nixVersion = "25.05";
        hostname = "nixos";
        system = "x86_64-linux";
        timeZone = "Europe/Paris";
        defaultLocale = "en_US.UTF-8";
        extraLocale = "fr_FR.UTF-8";
      };

      homeConfiguration = with homeConfiguration; {
        username = "willer";
        homeDir = "/home/${username}";

        kbLayout = "us";
        kbVariant = "altgr-intl";

        confDir = "${homeDir}/conf";
        dotfilesDir = "${confDir}/dotfiles";
        configDir = "${confDir}/config";
        scriptsDir = "${confDir}/scripts";
      };
      homeManagerSpecialArgs = {
        nixVersion = systemConfiguration.nixVersion;
        inherit homeConfiguration;
      };

      overlay-unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = systemConfiguration.system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs { system = systemConfiguration.system; config.allowUnfree = true; overlays = [ overlay-unstable ]; };
    in {
      nixosConfigurations.${systemConfiguration.hostname} = nixpkgs.lib.nixosSystem {
        system = systemConfiguration.system;
        inherit pkgs;
        specialArgs = {
          inherit inputs;
          inherit systemConfiguration;
          inherit homeConfiguration;
        };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${homeConfiguration.username} = import ./home.nix;

            home-manager.extraSpecialArgs = homeManagerSpecialArgs;
          }
        ];
      };
      homeConfigurations.${homeConfiguration.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = homeManagerSpecialArgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
