{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  services.blueman.enable = true;
  services.ratbagd.enable = true;
  hardware.logitech.wireless.enable = true;
}
