# modules/users/vvllnn/editor.nix
{ pkgs, ... }:

{
  # 编辑器配置 (neovim/vscode)
  # programs.neovim = {
  #   enable = true;
    # plugins = with pkgs.vimPlugins; [
    #   nvim-treesitter
    #   lualine-nvim
    # ];
    # extraConfig = ''
    #   lua << EOF
    #   require('lualine').setup()
    #   EOF
    # '';
  # };
  home.sessionVariables = {
    EDITOR = "vim";
  };
}