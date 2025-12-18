{
  description = "Kay's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.iusenixbtw = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/iusenixbtw
        ];
      };
    };
}
