# pacman-external-database

Upgrades pacman packages from a external database.

Based on [Installing packages from a CD/DVD or USB stick](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Installing_packages_from_a_CD/DVD_or_USB_stick)
from the Arch Wiki.

## Prerequisites

You will need the following packages on your system:

- coreutils
- bash
- ncurses
- pacman

And a working pacman configuration to download packages.

## Steps

### Download required packages

First, get a list of all required packages that you want to download.
We call it `pkglist.txt`.
Next, call the `download.sh` script and give it the path to this package list file:

```sh
./download.sh pkglist.txt
```

The script downloads packages with pacman with your pacman configuration.

### Copy downloaded packages

Now, copy the downloaded packages and a installation script to another path:

```sh
./copy.sh /mnt/external
```

The required files and packages are copied to the given path inside a `repo` directory.

### Install packages

With the copied packages and configuration files you can install these
on a computer without or bad internet connection.
Insert the external medium into the computer and mount it.
Now navigate into the `repo` directory on the external medium and execute:

```sh
./install.sh
```

This script creates a custom pacman configuration based on the `pacman.template.conf`
with only one repository to the `packages` directory.
This configuration is given to pacman and upgrades the system with the previously downloaded packages.

### Clean up your side

Now, the packages are copied onto the external medium,
remove the downloaded packages and configuration on your side:

```sh
./clean.sh
```

Finished!
