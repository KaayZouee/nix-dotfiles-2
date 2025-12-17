# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# This is Kay's configuration.nix <3


{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  nix = {
    package = pkgs.nixVersions.stable; # optional, but includes latest nix features
    extraOptions = ''
      experimental-features = nix-command  flakes
    '';
  };



###########################################
###  BLUETOOTH MOUSE (MX ANYWHERE 3S)   ###
###########################################

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true; # Show battery charge of Bluetooth devices
    };
  };
};

services.blueman.enable = true;
services.ratbagd.enable = true;
hardware.logitech.wireless.enable = true;



  hardware.graphics.enable = true;

  
#########################
###  VIRTUALIZATION   ###
#########################

virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;


##############################
###  BOOTLOADER & KERNEL   ###
##############################

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;


############################
###  /etc/resolv.conf   ###
############################



##################
###  NETWORK   ###
##################


networking.networkmanager.enable = true;
networking.networkmanager.dns = "none";

services.resolved.enable = false;

environment.etc."resolv.conf".text = ''
  nameserver 1.1.1.1
  nameserver 8.8.8.8
'';


#####################################################
###  INPUT METHODS, LANGUAGES AND TIME (BROKEN)   ###
#####################################################

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
    kdePackages.fcitx5-unikey
    ];
  };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  #keyboard backlit (asus vivobook laptop)
  boot.kernelModules = [ "asus-nb-wmi" ];

################
###  SHELL   ###
################

    programs.fish.enable = true; #Fish is default shell

###############
###  AUDIO  ###
###############

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    };
################
###  FONTS   ###
################

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.meslo-lg
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.fira-code
      fira-code
      fira
      font-awesome
    ];
  };

##################
###  FLATPAK   ###
##################

  xdg.portal.enable = true;
  # For flatpak.
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  services.flatpak.enable = true;

#################
###  FIREFOX  ###
#################

  programs.firefox.enable = true;


##############
###  USER  ###
##############

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kay = {
    isNormalUser = true;
    description = "kay";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.fish;
  };

###################
###  HOSTNAME   ###
###################

  networking.hostName = "iusenixbtw";

##############################
###  SYSTEM-WIDE PACKAGES  ###
##############################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    vscodium
    fcitx5
    kdePackages.fcitx5-unikey
    vim-full
    curl
    fish
    cargo
    go
    fd
    ripgrep
    sqlite
    gcc
    protonvpn-gui
    wl-clipboard
    cliphist
    imagemagick
    nodejs
    wget
    stow
    git
    pkgs.fastfetch
    btop
    cava
    dunst
    xfce.thunar
    jq
    mako
    grim slurp
    networkmanagerapplet
    brightnessctl
    spotify
    unzip
    adwaita-icon-theme
    fuchsia-cursor
    wine
    flatpak
    virt-manager
    virt-viewer
    swtpm
    gimp
    memos
    kiwix
    xclip
    pdf4qt
    ast-grep
    lazygit
    fzf
    python313
    python313Packages.pynvim
    python313Packages.pip
    lua51Packages.lua

  ];


#######################
###  OTHER STUFFS   ###
#######################

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
#   services.xserver.libinput.enable = true;





  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
