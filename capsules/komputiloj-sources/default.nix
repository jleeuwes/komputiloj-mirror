with builtins;
let
self = {
    sources = {
        nenio = fetchGit { inherit (self.pins.nenio.lock) url ref rev narHash; }; # bootstrap by going directly through fetchGit
        hello-infra = self.capsules.nenio.lib.lockedSource self.pins.hello-infra.lock;
    };

    capsules = {
        # For now, use our own copy of nenio.
        nenio = import ./nenio.nix;
        # We can switch to the online version of nenio when we have published it
        # publicly on github.
        # nenio = import self.sources.nenio;
    };
   
    pins = {
        nenio = {
            # TODO use github mirror here, otherwise restoring our systems
            # from scratch will be quite painful.
            track = {
                type = "git";
                url = "ssh://gitea@thee.radstand.nl/jeroen/nenio.git";
                ref = "main";
            };
            lock = {
                type = "git";
                url = "ssh://gitea@thee.radstand.nl/jeroen/nenio.git";
                ref = "main";
                rev = "4f15e06bf547509d94815c6cc72844d12d57df3c";
                narHash = "sha256-IrwQzI5zRyT0jvSyfN5Z6P2csu5aVPTp+JZd/llZEPA=";
            };
        };
        hello-infra = {
            track = {
                type = "git";
                url = "ssh://gitea@thee.radstand.nl/hello/infra.git";
                submodules = true;
                ref = "main";
            };
            lock = {
                type = "git";
                url = "ssh://gitea@thee.radstand.nl/hello/infra.git";
                submodules = true;
                ref = "main";
                rev = "3f31bd0dcef8af8380e916b90e72973ecdaa2086";
                narHash = "sha256-xjGbGzISklqp5dT+8aPWCGXI8E7NMG+nEIPlUjQsPUI=";
            };
        };
        nixos_26_05 = {
            # example, not used yet
            track = {
                type = "git";
                url = "https://github.com/NixOS/nixpkgs";
                ref = "nixos_26_05";
            };
        };
        lokaal = {
            # example, not used yet
            lock = {
                type = "path"; # implement with builtins.fetchTree with type=path; builtins.path is broken in pure eval mode
                path = "/home/jeroen/komputiloj/...";
                narHash = "sha256-...";
            };
        };
    };

}; in self
