{
  description = "我的 NixOS 配置";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    # override the default substituters
    substituters = [
      # cache mirror located in China
      # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      # status: https://mirrors.ustc.edu.cn/status/
      # "https://mirrors.ustc.edu.cn/nix-channels/store"

      "https://cache.nixos.org"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      # nix cache server public key
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # 推荐使用 unstable 获取最新软件，如果需要稳定性可选择 stable

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # home-manager 使用与 NixOS 相同的 nixpkgs 版本
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # 其他可能需要的输入，例如 nix-darwin, NUR, etc.
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-ld,
      ...
    }@inputs:
    {
      # @inputs 方便一次性传递所有 inputs
      # 定义 NixOS 配置
      nixosConfigurations = {
        # pve-Nixos 主机
        "pve-Nixos" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # 根据您的实际系统架构调整
          specialArgs = {
            inherit inputs; # 传递所有 Flake inputs，方便在模块中引用
            hostName = "pve-nixos"; # 传递主机名
            username = "vvllnn"; # 传递默认用户名
          };
          modules = [
            # 导入通用的系统、服务模块
            ./modules/default.nix # 聚合所有通用模块
            # 导入主机特定的配置入口
            ./hosts/pve-Nixos/configuration.nix
          ];
        };

        "ProArt" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            hostName = "ProArt";
            username = "vvllnn";
          };
          modules = [
            ./modules/default.nix
            ./hosts/ProArt/configuration.nix
          ];
        };

        "vps-Nixos" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            hostName = "vps-Nixos";
            username = "vvllnn";
          };
          modules = [
            ./modules/default.nix
            ./hosts/vps-Nixos/configuration.nix
          ];
        };
      };

      # 您还可以定义开发环境 (devShells)
      # devShells = {
      #   # 例如，一个用于 NixOS 开发的 shell
      #   default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      #     packages = with nixpkgs.legacyPackages.x86_64-linux; [
      #       nixos-rebuild
      #       git
      #       statix # Nix 代码格式化工具
      #       nixpkgs-fmt # Nix 代码格式化工具
      #     ];
      #   };
      # };

      # 其他可能的输出，例如 packages, apps, etc.
    };
}
