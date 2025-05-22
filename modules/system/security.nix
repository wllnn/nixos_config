# modules/system/security.nix
# 安全相关配置
{ config, pkgs, ... }:

{
  # networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 22 80 443 ]; # 示例：开放SSH, HTTP, HTTPS
  # security.sudo.wheelNeedsPassword = false;
}