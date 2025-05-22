# hosts/vps-Nixos/configuration.nix
# vps-Nixos 主机的实际配置
{ config, pkgs, lib, self, inputs, username, hostName, ... }:

{
  imports = [
    # 导入通用系统模块 (已经通过 modules/default.nix 导入)
    # 导入主机特定的硬件模块
    ./../../modules/hardware/vps-Nixos.nix
    # 导入主机特定的服务模块
    ./../../modules/services/nginx.nix
    ./../../modules/services/docker.nix
    ./../../modules/services/ssh.nix

    # 导入 Home Manager 模块
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.users.${username} = {
        imports = [
          ./../../modules/users/${username}/default.nix
          # VPS 通常不需要桌面相关配置
        ];
      };
    }
    # 导入 nix-ld 模块
    inputs.nix-ld.nixosModules.nix-ld
    { programs.nix-ld.dev.enable = true; } # 根据需求启用
  ];

  networking.hostName = hostName; # 从 specialArgs 获取主机名

  # VPS 通常不会有桌面环境，配置会更精简
  # 配置防火墙，只允许必要的端口
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ]; # SSH, HTTP, HTTPS

  # 用户创建 (确保用户存在)
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "wheel" "docker" ]; # 添加用户到必要组
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNzUyAABaWkR+Z46nsLmBaODjmNcJHFVVbNF4Fa6anH vvllnn@icloud.com" # 您的SSH公钥
    ];
    packages = with pkgs; [ ];
  };

  system.stateVersion = "25.05";
}