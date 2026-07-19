{ boltons, platform, nixos_26_05 }:
with boltons.lib;
let
pins = importDirAndApply ./pins.d {
    lib = nixos_26_05.lib;
    legacyPackages = nixos_26_05.native.${platform.localSystem}.legacyPackages;
};
self = {
    all = platform.lib.makeAll self;

    inherit pins;
    
    nixosModules = {
        mailserver = import pins.nixos-mailserver.lock.nix_path;
    };
    
}; in self
