# Arch Linux Installation Instructions

This guide now focuses on additional steps and packages to customize your system after installation. It shortens earlier steps for brevity since they are completed.

**Note:** Your internal hard drive is identified as `mmcblk1`. The USB installation media is `sda`. Adjust all commands accordingly.

---

## **1. Summary of Completed Steps**

- **Partitions Created:**
  - EFI partition (`/dev/mmcblk1p1`): 512MB, formatted as FAT32.
  - Root partition (`/dev/mmcblk1p2`): Remaining disk space, formatted as ext4.

- **Base System Installed:**
  ```bash
  pacstrap /mnt base linux linux-firmware
  genfstab -U /mnt >> /mnt/etc/fstab
  arch-chroot /mnt
  ```

- **Hostname, Locale, Timezone Configured:**
  - `/etc/hostname` set to `archlinux`.
  - `/etc/hosts` updated with loopback and hostname entries.
  - Locale set to `en_US.UTF-8`.
  - Timezone set and hardware clock synchronized.

- **GRUB Bootloader Installed and Tested:**
  GRUB was installed and configured. System rebooted successfully into Arch Linux.

---

## **2. Install Fonts**

### Why Fonts?
Fonts improve your system's visual appearance and support additional characters for various applications. If you want a **Minecraft-like theme**, or other options, here are some suggestions:

### Recommended Fonts:
1. **`ttf-dejavu`**:
   - A standard font family for most systems. Already installed.

2. **`ttf-fira-code`**:
   - A popular monospaced font with ligatures, ideal for programming.

3. **`ttf-cascadia-code`**:
   - Another great programming font.

4. **`ttf-minecraft`**:
   - Adds a Minecraft-inspired aesthetic.

### Install Fonts:
Run the following to install these fonts:
```bash
pacman -S ttf-fira-code ttf-cascadia-code
```
If you want the Minecraft font, install it using an AUR helper like `yay`:
```bash
yay -S ttf-minecraft
```

---

## **3. Install and Configure Audio**

### Steps:
1. Install `pipewire` and audio tools:
   ```bash
   pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber
   ```
2. Enable the PipeWire service:
   ```bash
   systemctl --user enable --now pipewire.service
   systemctl --user enable --now wireplumber.service
   ```
3. Test audio playback:
   ```bash
   speaker-test -t wav -c 2
   ```

---

## **4. Network Configuration with `nmtui`**

### Why `nmtui`?
`nmtui` is a simple terminal-based interface for managing network connections. It is especially useful for connecting to Wi-Fi networks during or after installation.

### Steps:
1. Install NetworkManager (if not already installed):
   ```bash
   pacman -S networkmanager
   ```

2. Enable and start the NetworkManager service:
   ```bash
   systemctl enable --now NetworkManager
   ```

3. Launch `nmtui` to configure your connection:
   ```bash
   nmtui
   ```
   - Select **Activate a Connection**.
   - Choose your Wi-Fi network from the list and enter the password.

4. Test the connection:
   ```bash
   ping -c 3 archlinux.org
   ```

---

## **5. Install `yay` (AUR Helper)**

### Why `yay`?
`yay` (Yet Another Yaourt) is an AUR helper that simplifies installing packages from the Arch User Repository (AUR). The AUR contains community-maintained packages not available in the official repositories.

### Steps:
1. Install prerequisites for building packages:
   ```bash
   pacman -S base-devel git
   ```

2. Clone the `yay` repository:
   ```bash
   git clone https://aur.archlinux.org/yay.git
   ```

3. Build and install `yay`:
   ```bash
   cd yay
   makepkg -si
   ```

4. Test `yay`:
   ```bash
   yay --version
   ```

You can now use `yay` to install AUR packages like this:
```bash
yay -S package-name
```

---

## **6. Install Hyperland (Wayland Compositor)**

### Why Hyperland?
Hyperland is a modern tiling Wayland compositor that provides a minimalist and efficient desktop experience.

### Steps:
1. Install dependencies:
   ```bash
   pacman -S wlroots wayland wayland-protocols
   ```
2. Use `yay` to install Hyperland:
   ```bash
   yay -S hyperland-git
   ```
3. Configure Hyperland:
   - Follow the official [Hyperland Wiki](https://wiki.archlinux.org/title/Hyperland).
   - Install a Wayland-compatible terminal like `alacritty`:
     ```bash
     pacman -S alacritty
     ```

---

## **7. Final Steps and Customization**

1. **Set Up a User Account**:
   ```bash
   useradd -m -G wheel -s /bin/bash your_username
   passwd your_username
   ```
   Grant admin privileges:
   ```bash
   EDITOR=nano visudo
   ```
   Uncomment:
   ```
   %wheel ALL=(ALL) ALL
   ```

2. **Install Additional Software**:
   - File Manager:
     ```bash
     pacman -S thunar
     ```
   - Web Browser:
     ```bash
     pacman -S firefox
     ```
   - Resource Monitor:
     ```bash
     pacman -S btop
     ```

3. **Reboot**:
   Once everything is installed, reboot to ensure all configurations are applied:
   ```bash
   reboot
   ```

---

Feel free to add additional packages, themes, or configurations to personalize your system further!

