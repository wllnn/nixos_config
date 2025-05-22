# modules/users/vvllnn/git.nix
{ pkgs, ... }:

{
  # Git 配置
  programs.git = {
    enable = true;
    userName = "vvllnn";
    userEmail = "vvllnn@icloud.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}