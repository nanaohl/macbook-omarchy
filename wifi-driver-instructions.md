# Instructions for Broadcom Wi-Fi on Arch Linux (BCM43602)

This file provides instructions on how to ensure the correct Wi-Fi driver (`brcmfmac`) is loaded for your Broadcom BCM43602 wireless card on Arch Linux.

## 1. Check which driver is currently loaded

Open a terminal and run the following commands to see which Broadcom driver is active:

```bash
lsmod | grep brcmfmac
lsmod | grep wl
```

*   If `brcmfmac` is listed, the correct, open-source driver is loaded.
*   If `wl` is listed, the proprietary Broadcom driver is loaded. This can sometimes cause issues and conflicts with `brcmfmac`.

## 2. How to switch to the `brcmfmac` driver

If the `wl` driver is loaded, you should unload it and load `brcmfmac`.

```bash
sudo modprobe -r wl
sudo modprobe brcmfmac
```

## 3. Making the driver selection permanent

To ensure `brcmfmac` is always loaded on reboot and `wl` is disabled, follow these steps:

### a) Force `brcmfmac` to load on boot:

Create a configuration file to load the `brcmfmac` module at startup:

```bash
echo "brcmfmac" | sudo tee /etc/modules-load.d/brcmfmac.conf
```

### b) Blacklist the `wl` driver (optional, but recommended if you have issues):

If the `wl` driver keeps loading, you can prevent it from loading by blacklisting it:

```bash
echo "blacklist wl" | sudo tee /etc/modprobe.d/blacklist-broadcom-wl.conf
```

## 4. Troubleshooting: Wi-Fi not working with `brcmfmac`

If the `brcmfmac` driver is loaded but your Wi-Fi is still not working, you might need to add a kernel parameter.

### a) Edit your bootloader configuration:

The file to edit depends on your bootloader (GRUB, systemd-boot, etc.).

*   **For GRUB:** Edit `/etc/default/grub` and add `brcmfmac.feature_disable=0x82000` to the `GRUB_CMDLINE_LINUX_DEFAULT` line.
    *   Example: `GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet brcmfmac.feature_disable=0x82000"`
    *   After editing, run `sudo grub-mkconfig -o /boot/grub/grub.cfg` to apply the changes.

*   **For systemd-boot:** Create a file `/boot/loader/entries/arch-options.conf` (or edit your existing entry file) and add the following line:
    *   `options brcmfmac.feature_disable=0x82000`

### b) Reboot your computer after making these changes.

## 5. Note on multiple wireless interfaces

Your system shows two wireless interfaces (`wlan0` and `wlan1`). This is unusual but not necessarily a problem. One of these should be your internal Wi-Fi card. You can use a network manager tool (like `nmcli`, `nmtui`, or a graphical one) to scan for networks and connect using one of these interfaces.