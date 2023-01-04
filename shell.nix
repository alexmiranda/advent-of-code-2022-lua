{ sources ? import ./nix/sources.nix { } }:
let pkgs = import sources.nixpkgs { };
in pkgs.mkShell rec {
  buildInputs = with pkgs; [
    luajit
    luajitPackages.busted
    luajitPackages.luacheck
    luajitPackages.inspect
    nixfmt
  ];
}
