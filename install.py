#!/usr/bin/env nix-shell
#!nix-shell -p python3 git -i python3

import subprocess
import os

print("Installation of SeTSeR's config.")

subprocess.check_output(["git", "submodule", "--init", "--recursive"])

config = "/mnt/etc/nixos/configuration.nix"

print("Creating ", config)
open(config, 'w').write('import %s', os.cwd())
print("Done")
print("Installing")
subprocess.check_output(["nixos-generate-config"])
subprocess.check_output(["nixos-generate-config", "--root", "/mnt"])
subprocess.check_output(["nixos-install", "--root", "/mnt"])
os.mkdir("/home/smakarov/.config/")
os.symlink("./.config/i3status", "/home/smakarov/.config/i3status")
os.symlink("./.config/nixpkgs", "/home/smakarov/.config/nixpkgs")
print("Done")
