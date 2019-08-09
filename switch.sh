#!/usr/bin/env nix-shell
#!nix-shell -p bash -i bash

unset IN_NIX_SHELL

export NIX_PATH=nixpkgs=./imports/nixpkgs:nixos-config=/etc/nixos/configuration.nix
export SHELL=/bin/sh

nix build -f ./imports/nixpkgs/nixos system $@ && {
    dir=$(pwd)
    pkexec nix-env --profile /nix/var/nix/profiles/system --set $(readlink $dir/result) &&
    pkexec $dir/result/bin/switch-to-configuration switch
}
