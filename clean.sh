#!/usr/bin/env bash

# Deletes packages and database.
# by Ludwig Richter <riluzm@posteo.de>

. env.sh

OLD_CWD="$(pwd)"
cd "${CWD}" || {
    printf "Could not change to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}

msg "Remove packages and database"
rm -rf "${PACKAGES_DIR}" custom.db* custom.files*

cd "${OLD_CWD}" || {
    printf "Could not change to %s\n" "${CWD}"
    exit $EXIT_FAILURE
}
