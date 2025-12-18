{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.kay = {
    isNormalUser = true;
    description = "kay";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };
}
