{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.meslo-lg
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-color-emoji
      fira-code
      fira
      font-awesome
    ];
  };
}
