#!/usr/bin/env bash

# Downloads the given packages to the packages folder
# and creates a custom database file inside the packages folder.
# by Ludwig Richter <riluzm@posteo.de>

. env.sh

OLD_CWD="$(pwd)"
cd "${CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}

msg "Create directories"
mkdir -p "${PACKAGES_DIR}" "${DBFILES_DIR}"

msg "Download packages"
# only download packages with custom database and cache directory
if ! $SUDO pacman --noconfirm -Syw --cachedir "${PACKAGES_DIR}" --dbpath "${DBFILES_DIR}" $@; then
    echo "Failed to download some packages"
    exit 1
fi

msg "Create custom database"

cd "${PACKAGES_DIR}" || {
    printf "Could not change directory to packages directory\n"
    exit $EXIT_FAILURE
}

# find all valid packages
packages="$(find . -type f -not -name "*.sig")" 
# add found packages to database
repo-add -q "custom.db.tar.zst" $packages

cd "${OLD_CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}
