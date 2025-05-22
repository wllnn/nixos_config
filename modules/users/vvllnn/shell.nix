# modules/users/vvllnn/shell.nix
{ pkgs, ... }:

{
  # Shell 配置 (zsh/bash/fish)
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    shellAliases = {
      ll = "ls -al";
    };
  };

  # 示例：如果您想启用 zsh
  # programs.zsh.enable = true;
  # programs.zsh.oh-my-zsh = {
  #   enable = true;
  #   plugins = [ "git" "z" ];
  # };
}