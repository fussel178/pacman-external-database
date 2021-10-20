#!/usr/bin/env bash

# Upgrades the local system with the given local repository.
# by Ludwig Richter <riluzm@posteo.de>

. env.sh

REPO_DIR="$(dirname "$(realpath "$0")")"

OLD_CWD="$(pwd)"
cd "${CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}

PACMAN_CONF_MOD="
[custom]
SigLevel = PackageRequired
Server = file://${REPO_DIR}/${PACKAGES_DIR}
"

msg "Generate pacman configuration"
cp -f pacman.template.conf pacman.conf
echo "$PACMAN_CONF_MOD" >> pacman.conf

msg "Upgrade system"
$SUDO pacman --config pacman.conf -Syu

cd "${OLD_CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}
