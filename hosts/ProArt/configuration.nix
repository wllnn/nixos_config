# hosts/ProArt/configuration.nix
# ProArt 主机的实际配置
{ config, pkgs, lib, self, inputs, username, hostName, ... }:

{
  imports = [
    # 导入通用系统模块 (已经通过 modules/default.nix 导入)
    # 导入主机特定的硬件模块
    ./../../modules/hardware/ProArt.nix
    # 导入主机特定的服务模块
    ./../../modules/services/ssh.nix # 桌面机也可能需要SSH
    # 导入 Home Manager 模块
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.users.${username} = {
        imports = [
          ./../../modules/users/${username}/default.nix
          ./../../modules/users/${username}/desktop.nix # ProArt 是桌面机，导入桌面相关配置
        ];
      };
    }
    # 导入 nix-ld 模块
    # inputs.nix-ld.nixosModules.nix-ld
    # { programs.nix-ld.dev.enable = true; } # 根据需求启用
  ];

  networking.hostName = hostName; # 从 specialArgs 获取主机名

  # 配置桌面环境 (示例：KDE Plasma)
  # services.xserver = {
  #   enable = true;
  #   displayManager.sddm.enable = true;
  #   desktopManager.plasma5.enable = true;
  # };

  # 用户创建 (确保用户存在)
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # 添加桌面环境所需的用户组
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNzUyAABaWkR+Z46nsLmBaODjmNcJHFVVbNF4Fa6anH vvllnn@icloud.com" # 您的SSH公钥
    ];
    packages = with pkgs; [ ];
  };

  system.stateVersion = "25.05";
}