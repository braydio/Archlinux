# Arch Linux Installation Instructions

Latest notes on Arch Linux install and setup process -
[Note!]
[full installation log at /archlog/](archlog/index.md)

---

## **1. Summary of Completed Steps**

- **Partitions Created:** EFI and root partitions set up and formatted.
- **Base System Installed:** Base packages and Linux kernel installed.
- **Hostname, Locale, Timezone Configured:** System name, language, and time synchronized.
- **GRUB Bootloader Installed and Tested:** GRUB successfully booted the system.
- **`yay` Installed:** AUR helper configured for managing community-maintained packages.
- **Network Configured:** NetworkManager enabled and Wi-Fi connected using `nmtui`.
- **Audio Configured:** PipeWire and ALSA utilities installed for sound.

---

## **2. Install Hyperland (Wayland Compositor)**

### **Set Up Graphics Drivers** (Important for Wayland)
To ensure Wayland functions properly, install the appropriate drivers for your system:

1. **For Intel GPUs:**
   ```bash
   pacman -S xf86-video-intel
   ```
2. **For AMD GPUs:**
   ```bash
   pacman -S xf86-video-amdgpu
   ```
3. **For NVIDIA GPUs:**
   ```bash
   pacman -S nvidia nvidia-utils
   ```

Additionally, ensure `mesa` is installed for OpenGL support:
```bash
pacman -S mesa
```

Once drivers are installed, proceed to install Hyperland:

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

## **3. Next Steps and Customization**

1. **Create Additional Users:**
   If needed, create additional user accounts:
   ```bash
   useradd -m -G wheel -s /bin/bash new_user
   passwd new_user
   ```
   Grant them sudo privileges:
   ```bash
   EDITOR=nano visudo
   ```

2. **Install Essential Applications:**
   - **File Manager:**
     ```bash
     pacman -S thunar
     ```
   - **Web Browser:**
     ```bash
     pacman -S firefox
     ```
   - **System Monitor:**
     ```bash
     pacman -S btop
     ```

3. **Set Up Power Management:**
   - For laptops, install `tlp`:
     ```bash
     pacman -S tlp
     systemctl enable --now tlp
     ```

4. **Enhance Terminal Experience:**
   - Install `neofetch` for system info:
     ```bash
     pacman -S neofetch
     ```
   - Install `exa` as an alternative to `ls`:
     ```bash
     pacman -S exa
     ```

5. **Customize Hyperland:**
   - Configure Hyperland's `.conf` files to match your preferred keybindings, layout, and visuals.
   - Consider installing themes or utilities like `rofi` or `waybar` for a polished look:
     ```bash
     pacman -S rofi waybar
     ```

6. **Back Up Your Configuration:**
   Save a copy of your system’s configuration files:
   ```bash
   cp /etc/{hostname,locale.conf,fstab} ~/backup/
   ```

7. **Reboot to Test Changes:**
   Once everything is configured:
   ```bash
   reboot
   ```

---

