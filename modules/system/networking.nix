# modules/system/networking.nix
# 网络通用配置
{ config, pkgs, lib, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Enables DHCP on each ethernet and wireless interface.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens2.useDHCP = lib.mkDefault true; # 如果有特定接口，可以在这里配置
}