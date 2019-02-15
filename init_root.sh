#!/usr/bin/env bash

mkdir -p /etc/nixos
if [[ ! -e /etc/nixos/configuration.nix ]] ; then
    ln -s `pwd`/configuration.nix /etc/nixos/configuration.nix
fi
