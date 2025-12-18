{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";

  services.resolved.enable = false;

  environment.etc."resolv.conf".text = ''
    nameserver 1.1.1.1
    nameserver 8.8.8.8
  '';

  networking.firewall.enable = true;
}
