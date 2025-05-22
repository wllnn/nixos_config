# hosts/vps-Nixos/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
  ];
}