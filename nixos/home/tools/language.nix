{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      python3
      clang

      cargo
      cargo-watch
      rustc
    ];
  };

  programs = {
    go.enable = true;
  };
}
