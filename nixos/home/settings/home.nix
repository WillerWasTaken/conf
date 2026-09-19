{ nixVersion, homeConfiguration, ... }:
{
  home = {
    username = homeConfiguration.username;
    homeDirectory = homeConfiguration.homeDir;

    stateVersion = nixVersion;
  };

  programs.home-manager.enable = true;
}
