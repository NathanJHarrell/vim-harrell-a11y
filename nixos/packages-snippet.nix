# NixOS packages snippet — add to environment.systemPackages in
# your packages.nix (or configuration.nix if you keep it monolithic).
#
# Why: vim is the daily driver. Neovim is installed but unconfigured —
# it's there for when we want to experiment with LSP / treesitter
# without running a curl-pipe-bash on a fresh machine.

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim                  # Dad's editor of choice. Classic, not neo.
    neovim               # For later experimentation (LSP, treesitter). Not configured yet.
  ];
}
