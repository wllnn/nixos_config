# modules/services/ssh.nix
{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  # services.openssh.settings.PasswordAuthentication = false;
  # services.openssh.settings.PermitRootLogin = "no";
  # services.openssh.settings.KbdInteractiveAuthentication = false;
}