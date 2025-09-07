
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  

  xdg.portal.enable = true;
  # For flatpak.
  xdg.portal = {
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
};
environment.variables = {
  GTK_IM_MODULE = "fcitx";
  QT_IM_MODULE = "fcitx";
  XMODIFIERS = "@im=fcitx";
};

i18n.inputMethod = {
  enable = true;
  type = "fcitx5";
  fcitx5.addons = with pkgs; [
    fcitx5-unikey
  ];
};


  nix = {
    package = pkgs.nixVersions.stable; # optional, but includes latest nix features
    extraOptions = ''
      experimental-features = nix-command  flakes
    '';
  };


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






#  programs.hyprland = {
#    enable = true;
#    xwayland.enable = true; # For X11 apps
#};

  hardware.graphics.enable = true;


  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  

users.groups.vboxusers = {};


  services.power-profiles-daemon.enable = true;

#i18n.inputMethod = {
#  type = "ibus";
#  enable = true;
#  ibus.engines = with pkgs.ibus-engines; [
#    bamboo
#  ];
#};




#########################
###  VIRTUALIZATION   ###
#########################

# VirtualBox host
#   virtualisation.virtualbox.host.enable = true;
#
#   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];



  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;     # Optional: TPM support
      ovmf.enable = true;      # UEFI support
    };
  };

  # Optional SPICE agent for better VM interaction
  services.spice-vdagentd.enable = false;


  programs.zsh.enable = true;
#  programs.zsh.ohMyZsh.enable = true; # Oh My Zsh support

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.grub.enable = true;
#  boot.loader.grub.version = 2;
#  boot.loader.grub.version = true;
#  boot.loader.grub.device = "nodev";
#  boot.loader.grub.useOSProber = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "iusenixbtw"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";







  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.resolvconf.enable = false;
  networking.dhcpcd.enable = false;







  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

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



  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
#   services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kay = {
    isNormalUser = true;
    description = "kay";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "libvirtd" ];
    shell = pkgs.zsh;    
    packages = with pkgs; [
    #  thunderbird
    ];
  };

#fonts.packages = with pkgs; [
#  nerd-fonts.fira-code
#  fira-code
#  fira
#  font-awesome
#];


fonts = {
  fontconfig.enable = true;
  packages = with pkgs; [
    nerd-fonts.meslo-lg
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.fira-code
    fira-code
    fira
    font-awesome

  ];
};


services.flatpak.enable = true;


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    vscodium
    fcitx5
    fcitx5-configtool
    fcitx5-unikey
    pkgs.libsForQt5.fcitx5-unikey
    vim-full
    curl
    fish
    cargo
    go
    fd
    ripgrep
    sqlite
    gcc
    xclip
    protonvpn-gui
    wl-clipboard
    cliphist
#    bluez
#    inotify-tools
#    trash-cli
#    foot
#    socat
    imagemagick
    nodejs
    fd
    wget
    stow
    git
    blueman
    piper
    pkgs.fastfetch
    btop
    cava
#    waybar
#    
#hyprland
#    hyprpaper
#    hyprlock
#    wofi
#    rofi-wayland
    dunst
    xfce.thunar
    jq
    wireplumber
    mako
    grim slurp
    wl-clipboard
#    xdg-desktop-portal-hyprland
#    xdg-desktop-portal-gtk
#    hyprpicker
#    hypridle    
#    kitty
    networkmanagerapplet
    brightnessctl
    pipewire
    pavucontrol
    noto-fonts noto-fonts-emoji
    fontconfig
    spotify
    unzip
    adwaita-icon-theme
    fuchsia-cursor
    wine
    flatpak
    zsh
    qemu
    virt-manager
    virt-viewer
    swtpm
    gimp
    memos
    kiwix
    xclip
    ast-grep
    lazygit
    fzf
    python313
    python313Packages.pynvim
    python313Packages.pip
    lua51Packages.lua

  ];

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
