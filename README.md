# Arch Linux Installation Instructions

This guide walks you through the steps of formatting and mounting partitions, followed by configuring your Arch Linux installation, setting up the hostname, installing GRUB, and installing essential packages.

**Note:** Your internal hard drive is identified as `mmcblk0`. The USB installation media is `sda`. Adjust all commands accordingly.

---

## **1. Format and Mount Partitions**

### Why format and mount?
- **Formatting** prepares the partitions by erasing data and setting up a filesystem that Arch Linux can use.
- **Mounting** attaches the partitions to directories so the system can use them during installation.

### Steps:

1. **Verify Disk Layout**:
   Identify the correct disk and partitions using:
   ```bash
   lsblk
   ```
   Example output:
   ```
   NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
   sda           8:0    1  16.0G  0 disk 
   mmcblk0     179:0    0  114.6G  0 disk 
   ├─mmcblk0p1 179:1    0   512M  0 part 
   └─mmcblk0p2 179:2    0 114.1G  0 part 
   ```
   - `mmcblk0p1`: EFI partition.
   - `mmcblk0p2`: Root partition.

2. **Format Partitions**:
   - Format the EFI partition:
     ```bash
     mkfs.fat -F32 /dev/mmcblk0p1
     ```
   - Format the root partition:
     ```bash
     mkfs.ext4 /dev/mmcblk0p2
     ```

3. **Mount Partitions**:
   - Mount the root partition:
     ```bash
     mount /dev/mmcblk0p2 /mnt
     ```
   - Create and mount the EFI directory:
     ```bash
     mkdir -p /mnt/boot
     mount /dev/mmcblk0p1 /mnt/boot
     ```

4. **Verify Mounts**:
   Check that the partitions are properly mounted:
   ```bash
   lsblk
   ```
   Expected output:
   ```
   NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
   mmcblk0     179:0    0  114.6G  0 disk 
   ├─mmcblk0p1 179:1    0   512M  0 part /mnt/boot
   └─mmcblk0p2 179:2    0 114.1G  0 part /mnt
   ```

---

## **2. Install the Base System**

Install the essential Arch Linux packages:
```bash
pacstrap /mnt base linux linux-firmware
```

---

## **3. Generate the Filesystem Table**

Create a table that defines how the system will mount your partitions at boot:
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Verify the contents of `/mnt/etc/fstab`:
```bash
cat /mnt/etc/fstab
```

---

## **4. Enter the Installed System**

Chroot into your installed system to configure it:
```bash
arch-chroot /mnt
```

---

## **5. Set Hostname**

**What is the hostname?**
- The hostname is the name of your computer on a network. It’s used to identify your system when connected to other devices or networks.

### Steps:
1. Choose a hostname (e.g., `archlinux`):
   ```bash
   echo "archlinux" > /etc/hostname
   ```
   This writes your chosen hostname to the `/etc/hostname` file, which is used during system initialization.

2. Configure the `/etc/hosts` file:
   ```bash
   cat <<EOF > /etc/hosts
   127.0.0.1   localhost
   ::1         localhost
   127.0.1.1   archlinux.localdomain   archlinux
   EOF
   ```
   - **127.0.0.1**: This is the loopback address, allowing the system to refer to itself.
   - **::1**: IPv6 equivalent of the loopback address.
   - **127.0.1.1**: Used for your hostname when connecting to a network. Replace `archlinux` with your chosen hostname.

---

## **6. Install GRUB Bootloader**

**What is GRUB?**
- GRUB (GRand Unified Bootloader) is software that loads your operating system when your computer starts. It’s essential for booting into Arch Linux.

### Steps:
1. Install GRUB and EFI utilities:
   ```bash
   pacman -S grub efibootmgr
   ```
   - **grub**: The bootloader itself.
   - **efibootmgr**: A tool to manage EFI entries for UEFI systems.

2. Install GRUB to your system:
   ```bash
   grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
   ```
   - **--target=x86_64-efi**: Specifies that we’re installing for a UEFI system.
   - **--efi-directory=/boot**: Points to the EFI partition where GRUB will store its files.
   - **--bootloader-id=GRUB**: Creates an entry called GRUB in your firmware’s boot manager.

3. Generate the GRUB configuration file:
   ```bash
   grub-mkconfig -o /boot/grub/grub.cfg
   ```
   This generates the file GRUB uses to manage boot entries and kernel parameters.

---

### **Reboot and Test GRUB Installation**
1. Exit the chroot environment:
   ```bash
   exit
   ```
2. Unmount all partitions:
   ```bash
   umount -R /mnt
   ```
3. Reboot your system:
   ```bash
   reboot
   ```

Upon reboot, GRUB should appear and boot into your Arch Linux system. If it fails, use the live ISO to troubleshoot as described earlier.

---

## **7. Install Essential Packages**

**Why are these packages needed?**
- These packages provide basic tools, utilities, and programs to make your system functional and user-friendly.

### Install the following packages:
```bash
pacman -S nano firefox btop thunar tldr exa pulseaudio git nmtui
```
- **nano**: A simple text editor for editing configuration files.
- **firefox**: A web browser for internet access.
- **btop**: A modern resource monitor.
- **thunar**: A lightweight file manager.
- **tldr**: Simplified man pages for commands.
- **exa**: A modern replacement for `ls`.
- **pulseaudio**: Audio server for sound management.
- **git**: A version control system for managing code and projects.
- **nmtui**: A text-based interface for managing network connections.

---

## **8. Final Steps**

1. Exit the chroot environment:
   ```bash
   exit
   ```

2. Unmount all partitions:
   ```bash
   umount -R /mnt
   ```

3. Reboot into your new system:
   ```bash
   reboot
   ```

4. After rebooting, log into your system and test your setup. If you encounter issues, boot into the live ISO and troubleshoot.

---

Feel free to add or modify packages and configurations as needed!

