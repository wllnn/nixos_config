# modules/users/vvllnn/desktop.nix
{ pkgs, ... }:

{
  # 桌面环境相关的用户级 Home Manager 配置
  # 仅在桌面主机（如 ProArt）的 Home Manager 配置中导入此模块
  home.packages = with pkgs; [
    # firefox # 浏览器
    # thunderbird # 邮件客户端
    # discord # 聊天
    # spotify # 音乐
    # vlc # 媒体播放器
    # 更多桌面应用...
  ];

  # 示例：启用 rofi (一个 dmenu 替代品)
  # programs.rofi.enable = true;

  # 示例：启用 alacritty 终端
  # programs.alacritty.enable = true;

  # 示例：启用 picom (合成器)
  # xsession.enable = true;
  # xsession.windowManager.xmonad.enable = true; # 示例：XMonad
  # xsession.windowManager.xmonad.extraPackages = with pkgs; [
  #   xmobar
  # ];
}