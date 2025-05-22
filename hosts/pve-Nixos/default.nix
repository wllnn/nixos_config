# hosts/pve-Nixos/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
  ];
}