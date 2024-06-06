# This shell is the "default" nix environment used by the following shell rc
# files:
# 
# + .zshrc
#
# TODO: It still needs to be implemented in:
#   + .bashrc

# TODO: Determine what package url to use?

{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    conda
    cowsay
    lolcat
    neovim
    nodejs_22
    python312
    stow
  ];
}
