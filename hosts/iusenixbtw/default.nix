{ pkgs, ... }:

let
  # Import package lists (simple lists, not NixOS modules)
  PKG_prolangs         = import ../../modules/PKG-prolangs.nix        { inherit pkgs; };
  PKG_editors          = import ../../modules/PKG-editors.nix         { inherit pkgs; };
  PKG_UtilitiesCLI     = import ../../modules/PKG-UtilitiesCLItools.nix { inherit pkgs; };
  PKG_systemnetworking = import ../../modules/PKG-systemnetworking.nix { inherit pkgs; };
  PKG_vpn              = import ../../modules/PKG-vpn.nix             { inherit pkgs; };
  PKG_multimedia       = import ../../modules/PKG-multimedia.nix      { inherit pkgs; };
  PKG_WMnoti           = import ../../modules/PKG-WMnoti.nix          { inherit pkgs; };
  PKG_themes          = import ../../modules/PKG-themes.nix          { inherit pkgs; };
  PKG_VM              = import ../../modules/PKG-VM.nix              { inherit pkgs; };
  PKG_ricing          = import ../../modules/PKG-forricing.nix       { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot.nix
    ../../modules/bluetooth.nix
    ../../modules/desktop-xfce.nix
    ../../modules/fonts.nix
    ../../modules/inputmethod.nix
    ../../modules/networking.nix
    ../../modules/sound.nix
    ../../modules/users.nix
    ../../modules/virtualization.nix

  ];

  networking.hostName = "iusenixbtw";

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Bangkok";

  system.stateVersion = "25.11";

environment.systemPackages =
     PKG_prolangs
  ++ PKG_editors
  ++ PKG_UtilitiesCLI
  ++ PKG_systemnetworking
  ++ PKG_vpn
  ++ PKG_multimedia
  ++ PKG_WMnoti
  ++ PKG_themes
  ++ PKG_VM
  ++ PKG_ricing;

}
