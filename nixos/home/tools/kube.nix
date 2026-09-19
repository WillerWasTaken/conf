{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      krew
      kubectl
      kubectx
      kconf
      kubernetes-helm
      kind
    ];

    file = {
      ".kubectl_aliases".source = builtins.fetchurl {
        url = https://raw.githubusercontent.com/ahmetb/kubectl-aliases/refs/heads/master/.kubectl_aliases;
      };
    };
  };

  programs = {
    kubecolor = {
      enable = true;
      enableAlias = true;
      enableZshIntegration = true;
    };

    k9s.enable = true;
  };
}
