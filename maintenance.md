# System maintenance

## Check for errors

Check if any systemd services have failed:

```bash
systemctl --failed
```

Look for errors in the log files located in /var/log/, as well as high priority errors from the systemd log:

```bash
journalctl -p 3 -xb
```

Look for errors in the log files located in /var/log/, as well as messages logged in the systemd journal:

```bash
journalctl -b
```

Error boot only:

```bash
journalctl -p err
```

```bash
journalctl -p err -b
```

## Exemple error

Arch Linux guest instances in VMware sometimes come up with the boot error message:

```bash
piix4_smbus 0000.00.07.0: SMBus base address uninitialized…
```

This error is being caused because VMware doesn’t actually provide that level interface for CPU access.

How to fix it:

```bash
sudo nano /etc/modprobe.d/blacklist.conf
```

add the line:

```bash
blacklist i2c-piix4
```

To (re-)generate initramfs images based on all existing presets:

```bash
mkinitcpio -P
```

```bash
reboot
```

## Return to an earlier package version

If a package was installed at an earlier stage, and the pacman cache was not cleaned, install an earlier version from /var/cache/pacman/pkg/:

```bash
sudo pacman -U file:///var/cache/pacman/pkg/package-old_version.pkg.tar.type
```

Downgrading the kernel:

```bash
sudo pacman -U file://linux-4.15.8-1-x86_64.pkg.tar.xz file://linux-headers-4.15.8-1-x86_64.pkg.tar.xz file://virtualbox-host-modules-arch-5.2.8-4-x86_64.pkg.tar.xz
```

## Check for packages 

Check for orphans packages:

```bash
sudo pacman -Qtd
```

Check for foreign packages:

```bash
sudo pacman -Qm
```

Clean cache:

```bash
sudo pacman -Sc
```

```bash
yay -Sc && yay -Yc
```

## Enable paccache (automatic cleaning of pacman cache)

The `pacman-contrib` package provides the `paccache` script which cleans the `pacman` cache by deleting old cached packages versions.  
To run `paccache` automatically on a weekly basis, enable the associated systemd timer:

```bash
sudo systemctl enable --now paccache.timer
```
