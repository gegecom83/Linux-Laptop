# niri: A scrollable-tiling Wayland compositor. 

This is my personal installation of niri with the Arch Linux installer and openSSH connection.

## Pre-configuration

```bash
loadkeys fr
```
```bash
ping -c 4 archlinux.org
```

### Arch Installer

```bash
pacman-key --init
```
```bash
pacman -Sy archinstall
```
```bash
archinstall
```

    "language: "English",
    "kb_layout": "fr",
    "mirror_regions": "France",
    "fstype": "ext4",
    "swap": true,
    "hostname": "archlinux",
    "autentification": "root", "user": "gegecom83",
    "kernels": "linux",
    "bootloader": "Systemd-boot",
    "profile": "Minimal",
    "applications": "audio": "pipewire", "fonts": "noto-fonts ...",
    "network": "Network-Manage (iwd backend)",
    "timezone": "Europe/Paris",
    "ntp": "Enabled"


### After reboot

```bash
sudo pacman -Syu
```
```bash
sudo pacman -S nano intel-ucode openssh fastfetch
```

### Enable ssh

```bash
sudo systemctl enable --now sshd.service
```
```bash
fastfetch
```

### Connect  ssh

```bash
ssh gegecom83@xxx.xx.xxx.xx
```

## Configuration and install

### Configure pacman

```bash
sudo nano /etc/pacman.conf
```
```bash
[...]
Color
[...]
ParallelDownloads = 10
[...]
```

### Use a more secure umask for the boot partition

```bash
sudo nano /etc/fstab
```
```bash
[...],fmask=0077,dmask=0077[...]
```

### Configure boot

```bash
sudo nano /boot/loader/loader.conf
```
```bash
timeout 0  
console-mode max  
editor no
```

### Install bluetooth

```bash
sudo pacman -S bluez bluez-utils 
```
```bash
sudo systemctl enable --now bluetooth
```

### Manage power profiles

```bash
sudo pacman -S power-profiles-daemon
```
```bash
sudo systemctl enable --now power-profiles-daemon.service
```

### Install niri

- niri with a few additional packages according to my personal preferences.

```bash
sudo pacman -S niri alacritty fuzzel mako swaybg swayidle waybar rofi libnotify playerctl brightnessctl blueman xdg-desktop-portal-gtk xdg-desktop-portal-wlr xdg-user-dirs polkit-gnome pavucontrol xorg-xwayland  xwayland-satellite firefox thunderbird thunar mousepad xfce4-terminal network-manager-applet zip unrar 7zip unzip ristretto gimp thunar-archive-plugin gvfs xarchiver gnome-keyring git base-devel devtools man-db man-pages bash-completion pacman-contrib ntfs-3g fuse2 fuse2fs fuse3 exfatprogs libappimage gspell wl-clipboard wl-clip-persist libadwaita adwaita-cursors adwaita-fonts adwaita-icon-theme gnome-themes-extra papirus-icon-theme keepassxc otf-font-awesome htop mpv ttf-nerd-fonts-symbols xdg-utils
```

### Autostart niri after logging

```bash
nano ~/.bash_profile
```

```text
# Autostart niri
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        export XDG_CURRENT_DESKTOP=niri
        export XDG_SESSION_DESKTOP=niri
        export XDG_SESSION_TYPE=wayland
        export QT_QPA_PLATFORM=wayland
        export SDL_VIDEODRIVER=wayland
        exec niri-session -l
fi
```

### Creating default directories

```bash
xdg-user-dirs-update
```

### Install the paru AUR Helper

```bash
git clone https://aur.archlinux.org/paru.git
```
```bash
cd paru
```
```bash
makepkg -si
```
```bash
mkdir -p ~/.config/paru
```
```bash
nano ~/.config/paru/paru.conf
```
```bash
[options]
AurOnly
UpgradeMenu
Chroot
```

### Install Clipboard

```bash
paru clipman
```

### Install Swaylock

```bash
paru swaylock-effects
```

### Install Arch-update

```bash
paru arch-update
```
```bash
systemctl --user enable --now arch-update.timer
```
```bash
arch-update --gen-config
```
```bash
nano ~/.config/arch-update/arch-update.conf
```
```bash
[...]
TrayIconStyle= light # light / dark / blue
[...]
```

### Install Oniri

```bash
paru oniri
```

### Mask hibernate and sleep

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

### Enable fstrim

```bash
sudo systemctl enable --now fstrim.timer
```

### Install firewall

```bash
sudo pacman -S firewalld
```
```bash
sudo systemctl enable --now firewalld
```
```bash
sudo firewall-cmd --remove-service="ssh" --permanent
```
```bash
sudo firewall-cmd --remove-service="dhcpv6-client" --permanent
```
```bash
sudo firewall-cmd --reload
```

### Disable ssh

```bash
sudo systemctl disable sshd.service
```

### Reboot system

```bash
sudo reboot
```

## Dotfiles

- Clone the repository

```bash
git clone https://github.com/gegecom83/Linux-Laptop.git
```

## My customization

### Dark themes

```bash
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
```

### Qt6 Settings

```bash
paru qt6ct-kde
```
```bash
nano ~/.bash_profile
```
```bash
[...]
export QT_QPA_PLATFORMTHEME=qt6ct
[...]
```

### Qt 6 integration configuration

```bash
sudo pacman -S plasma-integration
```

### Fix error dbus-broker-launch

```bash
sudo mv /usr/share/dbus-1/services/org.kde.plasma.Notifications.service /usr/share/dbus-1/services/org.kde.plasma.Notifications.service.bak
```

### Install for my projects

```bash
sudo pacman -S sdl2_ttf curl openssl lua sdl2_image sdl2 python-pyqt6
```
```bash
sudo pacman -S wine winetricks noto-fonts-cjk zenity
```
```bash
fc-cache -fv
```
```bash
winetricks cjkfonts
```
```bash
sudo pacman -S code distrobox podman
```

### Browse network

```bash
sudo pacman -S gvfs gvfs-smb sshfs avahi gvfs-dnssd wsdd
```
```bash
sudo systemctl enable --now avahi-daemon
```
```bash
sudo systemctl enable --now wsdd
```
```bash
sudo firewall-cmd --permanent --add-service=samba
```
```bash
sudo firewall-cmd --reload
```
