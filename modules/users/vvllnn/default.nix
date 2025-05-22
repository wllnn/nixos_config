# modules/users/vvllnn/default.nix
# 聚合用户 vvllnn 的 Home Manager 配置
{ config, pkgs, lib, ... }:

{
  imports = [
    # 导入用户 vvllnn 的各个 Home Manager 子模块
    ./applications.nix
    ./editor.nix
    ./git.nix
    ./shell.nix
    # ./desktop.nix # 桌面相关配置，只在桌面主机上导入，不在通用 default.nix 中导入
  ];

  home.username = "vvllnn";
  home.homeDirectory = "/home/vvllnn";
  home.stateVersion = "25.05"; # 确保与您的 Home Manager 版本兼容

  # 从您之前的 home.nix 中提取的通用配置
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  programs.home-manager.enable = true; # 让 Home Manager 管理自身
}