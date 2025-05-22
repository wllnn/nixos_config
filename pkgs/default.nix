# pkgs/default.nix
{ pkgs ? import <nixpkgs> { } }:

{
  # 您可以在这里定义您的自定义 Nix 包
  # 例如：
  # my-app = pkgs.stdenv.mkDerivation {
  #   pname = "my-app";
  #   version = "1.0";
  #   src = ./my-app-source;
  #   # ...
  # };
}