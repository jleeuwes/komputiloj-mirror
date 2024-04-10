{ boltons, komputiloj, nixpkgsCurrent, ... }:
with boltons;
komputiloj.lib.writeCommand {
    name = "moo";
    runtimeInputs = [ nixpkgsCurrent.packages.cowsay ];
    text = ''
        if [[ $# -eq 0 ]]; then
            cowsay 'MOO!'
        else
            cowsay -e oO -- "$@"
        fi
    '';
}
