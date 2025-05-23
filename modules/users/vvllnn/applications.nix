# modules/users/vvllnn/applications.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    zip
    xz
    unzip
    p7zip
    eza # A modern replacement for ‘ls’
    mtr # A network diagnostic tool
    iperf3
    btop # replacement of htop/nmon
  ];
}