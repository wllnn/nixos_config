# modules/default.nix
# 聚合所有自定义的通用系统模块
{ config, pkgs, lib, ... }:

{
  imports = [
    ./system/base.nix
    ./system/security.nix
    ./system/networking.nix
    # 将来可以在这里添加更多通用模块，例如 ./services/common.nix
    # 但具体服务通常在主机配置中按需导入
  ];
}