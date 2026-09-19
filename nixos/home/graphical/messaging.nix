{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      unstable.rambox
      signal-desktop
    ];
  };
}
