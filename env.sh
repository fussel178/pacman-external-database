# use clean path
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

EXIT_SUCCESS=0
EXIT_FAILURE=1

CWD="$(pwd)"
# directory of packages to download to
PACKAGES_DIR="packages"
# temporary database files for pacman
DBFILES_DIR="db"

# use tput for colored output if possible
if tput setaf 0 > /dev/null 2>&1; then
	DEFAULT="$(tput sgr0)"
	BOLD="$(tput bold)"
	WHITE="$(tput setaf 7)"
	MAGENTA="$(tput setaf 5)"
else
	DEFAULT="\e[0m"
	BOLD="\e[1m"
	WHITE="\e[97m"
	MAGENTA="\e[33m"
fi

if [ "$(id -u)" = "0" ]; then
    # user has privileges -> skip sudo
    SUDO=""
else
    SUDO="sudo"
fi

msg() {
    printf "${BOLD}${MAGENTA}<<=>>${DEFAULT}${BOLD} %s${DEFAULT}\n" "$@"
}
