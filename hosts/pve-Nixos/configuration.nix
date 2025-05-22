# hosts/pve-Nixos/configuration.nix
# pve-Nixos 主机的实际配置，导入通用模块和主机特定模块
{ config, pkgs, lib, self, inputs, username, hostName, ... }: # 接收 specialArgs 传递的参数

{
  imports = [
    # 导入主机特定的硬件模块
    ./../../modules/hardware/pve-Nixos.nix
    # 导入主机特定的服务模块
    ./../../modules/services/nginx.nix
    ./../../modules/services/docker.nix
    ./../../modules/services/ssh.nix # PVE主机通常也需要SSH

    # 导入 Home Manager 模块，作为 NixOS 配置的一部分
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.users.${username} = { # 使用传递的 username
        imports = [
          # 导入用户的 Home Manager 聚合模块
          ./../../modules/users/${username}/default.nix
          # PVE主机通常没有桌面，所以这里不需要导入 desktop.nix
        ];
      };
    }

    # 导入 nix-ld 模块
    inputs.nix-ld.nixosModules.nix-ld
    { programs.nix-ld.dev.enable = true; } # 根据您的需求决定是否启用 dev 模式

    # ... 其他导入模块 ...
  ];

  # 从 specialArgs 中获取主机名，避免硬编码
  networking.hostName = hostName;

  # 用户创建 (从您原有的 pve-Nixos.nix 提取)
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker" # 如果使用docker，需要将用户加入docker组
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNzUyAABaWkR+Z46nsLmBaODjmNcJHFVVbNF4Fa6anH vvllnn@icloud.com" # 您的SSH公钥
    ];
    packages = with pkgs; [ ];
  };

  # X11 配置 (如果 PVE 主机没有 GUI，可以移除或注释掉)
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 其他主机特定的系统级配置 虚拟机不支持
  # services.smartd.enable = true; # 启用 SMART 监控

  # 这个值确定了系统状态数据（如文件位置和数据库版本）的默认设置来自哪个 NixOS 发布版本
  system.stateVersion = "25.05"; # 请确保您已阅读文档并理解此选项的含义
}