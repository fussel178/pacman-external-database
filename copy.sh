#!/usr/bin/env bash

# Copies the downloaded packages and database to a external destination.
# It creates an installer script to install the most recent packages, too.
# by Ludwig Richter <riluzm@posteo.de>

. env.sh

if [ -z "$1" ]; then
    echo "No copy path given."
    exit $EXIT_FAILURE
fi
TARGET_PATH="$1"

# final check before force copy
echo "Copy packages to ${TARGET_PATH}/repo? "
select yn in "Yes" "No"; do
    case "$yn" in
        No) exit;;
    esac
done

OLD_CWD="$(pwd)"
cd "${CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}

msg "Copy repo"
mkdir -p "${TARGET_PATH}/repo"
cp -rfa packages pacman.template.conf install.sh env.sh "${TARGET_PATH}/repo/"

cd "${OLD_CWD}" || {
    printf "Could not change directory to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}
