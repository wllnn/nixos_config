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
    fzf # A command-line fuzzy finder

    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    nix-output-monitor
    # productivity
    btop # replacement of htop/nmon
    nixfmt-rfc-style
  ];
}