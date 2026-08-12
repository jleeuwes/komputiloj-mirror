with builtins;
let privateLib = rec {
    lockedSource = lock: {
        git = lockedGitSource (removeAttrs lock ["type"]);
    }.${lock.type};
    
    lockedGitSource = {
        url,
        submodules ? false,
        ref,
        rev,
        narHash
    }: fetchGit {
        inherit url submodules ref rev narHash;
    };
}; in {
    lib = {
        inherit (privateLib) lockedSource;
    };
}
