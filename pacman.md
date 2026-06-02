# Package Manager

## pacman

Pacman commands follow this structure:

```sh
sudo pacman <operation> [options] [targets]
```

Example:

```sh
pacman -Syu
```

-S: Synchronize packages.
-y: Refresh the database.
-u: Upgrade all packages to the latest versions.


| Command                               | Description                                                  |
|-----------------------------------------|--------------------------------------------------------------|
| sudo pacman -S                               | Install packages from the repositories                       |
| sudo pacman -S --asdeps                               | Install packages as dependencies of another package          |
| sudo pacman -S --nodeps                               | Install packages and ignore all dependency checks of another package          |
| sudo pacman -S --needed                              | Do not reinstall a package that are already up-to-date.         |
| pacman -Si                               | Display information about a package in the repositories      |
| pacman -Ss                               | Search for packages in the repositories                      |
| sudo pacman -Sy                               | Update and refresh the local package database                |
| sudo pacman -Syy                               | Force refresh of all package lists after updating mirrorlist |
| sudo pacman -Syu                               | Sync with repositories before upgrading packages             |
| sudo pacman -U                               | Install a package from a local file                          |
| sudo pacman -R                               | Remove packages, keeping its settings and dependencies       |
| sudo pacman -Rns                               | Remove packages, including its settings and dependencies     |
| sudo pacman -Q                             | List all packages installed                                  |
| pacman -Qi                               | Display information about a package in the local database    |
| pacman -Qs                               | Search for packages in the local database                    |
| sudo pacman -Qdt                               | List all orphaned packages                                   |
| pacman -Ql                               | List files in a package                                      |
| pacman -Qo                               | Show which package owns a file                               |
| sudo pacman -Fy                               | Download fresh package databases from the server             |
| pacman -F                               | Search package file names for matching strings               |


Update mirror list:

```sh
sudo pacman-mirrors -g
```

Reconfiguring mirrors:

```sh
sudo pacman-mirrors -g
```

Update keys:

```sh
sudo pacman -Sy --needed archlinux-keyring
```

Count of installed packages:

```sh
sudo pacman -Qq | wc -l
```

## yay

| Command                           | Description                                                                                                |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| yay                             | Alias to yay -Syu                                                                                       |
| yay <Search Term>               | Present package-installation selection menu.                                                               |
| yay -Bi <dir>                   | Install dependencies and build a local PKGBUILD.                                                           |
| yay -G <AUR Package>            | Download PKGBUILD from ABS or AUR. (yay v12.0+)                                                            |
| yay -Gp <AUR Package>           | Print to stdout PKGBUILD from ABS or AUR.                                                                  |
| yay -Ps                         | Print system statistics.                                                                                   |
| yay -Syu --devel                | Perform system upgrade, but also check for development package updates.                                    |
| yay -Syu --timeupdate           | Perform system upgrade and use PKGBUILD modification time (not version number) to determine update.        |
| yay -Wu <AUR Package>           | Unvote for package (Requires setting `AUR_USERNAME` and `AUR_PASSWORD` environment variables) (yay v11.3+) |
| yay -Wv <AUR Package>           | Vote for package (Requires setting `AUR_USERNAME` and `AUR_PASSWORD` environment variables). (yay v11.3+)  |
| yay -Y --combinedupgrade --save | Make combined upgrade the default mode.                                                                    |
| yay -Y --gendb                  | Generate development package database used for devel update.                                               |
| yay -Yc                         | Clean unneeded dependencies.                                                                               |

## paru

| Command            | Description                |
| ------------------ | -------------------------- |
| paru <target>      | Interactively search and install <target> |
| paru               | Alias for paru -Syu |
| paru -S <target>   | Install a specific package |
| paru -Sua          | Upgrade AUR packages |
| paru -Qua          | Print available AUR updates |
| paru -G <target>   | Download the PKGBUILD and related files of <target> |
| paru -Gp <target>  | Print the PKGBUILD of <target> |
| paru -Gc <target>  | Print the AUR comments of <target> |
| paru --gendb       | Generate the devel database for tracking *-git packages. This is only needed when you initially start using paru |
| paru -Bi .         | Build and install a PKGBUILD in the current directory |

## pactree

| Command            | Description                |
| ------------------ | -------------------------- |
| pactree <pkg>      | What does _pkg_ depend on? |
| pactree -r <pkg>   | What depends on _pkg_?     |


---
