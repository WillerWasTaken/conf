{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # https://github.com/NixOS/nixpkgs/issues/121694#issuecomment-2159420924
      # Disable apparmor
      (writeShellScriptBin "rambox" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${unstable.rambox}/bin/rambox "$@"
      '')
      (writeShellScriptBin "signal-desktop" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${signal-desktop}/bin/signal-desktop "$@"
      '')
    ];
  };
}
