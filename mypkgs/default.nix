# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, ... }:
{
  kanata = pkgs.callPackage ./kanata { };
  karabiner-driverkit = pkgs.callPackage ./karabiner-driverkit { };
}
