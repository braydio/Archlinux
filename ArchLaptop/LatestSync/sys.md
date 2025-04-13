# System Files

## Index

- [fstab](#section-1)

## fstab
<a id="section-1"></a>

# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
# /dev/mmcblk0p2
UUID=9a758e0d-bd97-491d-925a-0f5cac96ccba	/         	ext4      	rw,relatime	0 1

# /dev/mmcblk0p1
UUID=3249-4DBD      	/boot     	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro	0 2

# RAM Swapfile
/swapfile none swap sw 0 0

# Network Attached Storage
192.168.1.239:/mnt/netstorage /mnt/netstorage nfs defaults,noatime 0 0

# Shared drive from Desktop
//192.168.1.68/Shared /home/braydenchaffee/mnt/windows-share cifs credentials=/home/braydenchaffee/.smbcredentials,rw,uid=1000,gid=1000,vers=3.0 0 0

# Jellyfin Stuff
//192.168.1.68/Jellyfin /home/braydenchaffee/mnt/TempMedia cifs credentials=/home/braydenchaffee/.smbcredentials,rw,uid=1000,gid=1000,vers=3.0 0 0





- [hostname](#section-2)

## hostname
<a id="section-2"></a>

archlinux



- [hosts](#section-3)

## hosts
<a id="section-3"></a>

127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux.localdomain archlinux



- [pacman.conf](#section-4)

## pacman.conf
<a id="section-4"></a>

#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
Architecture = auto

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
#Color
#NoProgressBar
CheckSpace
VerbosePkgLists
ParallelDownloads = 5
DownloadUser = alpm
#DisableSandbox

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with `pacman-key --populate archlinux`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

#[core-testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

#[extra-testing]
#Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

# If you want to run 32 bit applications on your x86_64 system,
# enable the multilib repositories as required here.

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

#[multilib]
#Include = /etc/pacman.d/mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs



- [zram-generator.conf](#section-5)

## zram-generator.conf
<a id="section-5"></a>

[zram0]
zram-size = ram / 2
compression-algorithm = zstd



- [.bashrc](#section-6)

## .bashrc
<a id="section-6"></a>

# ~/.bashrc
# Exit if not running interactively
[[ $- != *i* ]] && return

# TEMPORARY
# echo OpenAI Email Assistant
# echo OpenAI Alpaca API

# Environment Variables
export TERM=xterm-256color
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Changed below when bash wasnt working, now idk which to use
# export PATH="$PATH:/usr/local/bin"
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export FZF_DEFAULT_OPTS="--color=fg:#ebdbb2,bg:#282828,hl:#458588" # Colors for FZF
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
PATH=usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
# Add pyenv to PATH
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"

# Aliases from .bash_aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# SSH Persistence (Auth) - check if running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

# Bash Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash # Fuzzy finder Bash completion

bind 'TAB:menu-complete'               # Tab cycling
bind '"\e[Z": menu-complete-backward'  # Shift tab back-cycling
bind '"\e[B": history-search-forward'  # History aware completion
bind '"\e[A": history-search-backward' # History aware backwards
bind "set colored-stats on"

# Functions
cdr() {
  clear && cd "$1" && ls -a --color=auto
}

cds() {
  cd "$1" && ls -a --color=auto
}

cdc() {
  cd "$HOME/$1" && ls -a --color=auto
} # Because fuck a tilde (is that a tilde? Is that even how you spell it?)

# Prompt
PS1='\[\e[0;32m\][\u@\h \W]\$ \[\e[m\]'



- [.zshrc](#section-7)

## .zshrc
<a id="section-7"></a>


export TERM=xterm-256color
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/braydenchaffee/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall



- [hyprland.conf](#section-8)

## hyprland.conf
<a id="section-8"></a>


# #######################################################################################
#
# #######################################################################################

# https://wiki.hyprland.org/Configuring/

# You can split this configuration into multiple files
# Create your files separately and then link them to this file like this:
# source = ~/.config/hypr/myColors.conf


################
### MONITORS ###
################

# See https://wiki.hyprland.org/Configuring/Monitors/

monitor=eDP-1, preferred, auto, auto
monitor=HDMI-A-1, preferred, auto-up, auto

###################
### MY PROGRAMS ###
###################

# See https://wiki.hyprland.org/Configuring/Keywords/

# Set programs that you use
$terminal = kitty
$fileManager = dolphin
$menu = wofi --show drun
$keyreference = ~/Scripts/utility/KeybindSearch.py
$kitty = ~/Scripts/kitty/launch-kitty.sh

#################
### AUTOSTART ###
#################

# Autostart necessary processes (like notifications daemons, status bars, etc.)
# Or execute your favorite apps at launch like this:

exec-once = $kitty
exec-once = waybar & hyprpaper & mako
exec-once = firefox --kiosk http://chat.openai.com
# exec-once = qbittorrent


#############################
### ENVIRONMENT VARIABLES ###
#############################

# See https://wiki.hyprland.org/Configuring/Environment-variables/

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24

#####################
### LOOK AND FEEL ###
#####################

# Refer to https://wiki.hyprland.org/Configuring/Variables/
# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors


# Custom Test gap settings
# Set inner and outer gaps to zero
# Refer to https://wiki.hyprland.org/Configuring/Variables/

general {
    gaps_in = 2   # No gaps between windows
    gaps_out = 10  # No gaps between windows and the screen edge
    border_size = 4
    resize_on_border = false
    allow_tearing = false
    layout = dwindle
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
}

decoration {
    rounding = 0  # No rounded corners
    active_opacity = 1.0
    inactive_opacity = 0.8
    shadow {
        enabled = true
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
    }
    blur {
        enabled = true
        size = 7
        passes = 4
        new_optimizations = true
        vibrancy = 0.1696
    }
}



# https://wiki.hyprland.org/Configuring/Variables/#animations
animations {
    enabled = true # yes, please :)

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1

    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade
}

# Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
# "Smart gaps" / "No gaps when only"
# uncomment all if you wish to use that.
# workspace = w[tv1], gapsout:0, gapsin:0
# workspace = f[1], gapsout:0, gapsin:0
# windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
# windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
dwindle {
    pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # You probably want this
}

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
master {
    new_status = master
}

# https://wiki.hyprland.org/Configuring/Variables/#misc
misc {
    force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
}


#############
### INPUT ###
#############

# https://wiki.hyprland.org/Configuring/Variables/#input
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    touchpad {
        natural_scroll = false
    }
}

# https://wiki.hyprland.org/Configuring/Variables/#gestures
gestures {
    workspace_swipe = true		# Enable wkspace switching    
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

###################
### KEYBINDINGS ###
###################

# See https://wiki.hyprland.org/Configuring/Keywords/
$mainMod = SUPER # Sets "Windows" key as main modifier

# Main binds
bind = $mainMod, W, exec, ~/Scripts/kitty/launch-kitty.sh
bind = $mainMod, Q, killactive
bind = $mainMod, E, exec, dolphin
bind = $mainMod, F, fullscreen
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, Return, exec, kitty
bind = $mainMod SHIFT, Return, exec, ghostty
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, #dwindle
bind = $mainMod, K, exec, hyprctl dispatch focuswindow "title:wayterm"
bind = $mainMod SHIFT, N, exec, hyprctl dispatch splitratio -0.3
bind = $mainMod SHIFT, M, exec, hyprctl dispatch splitratio +0.3

#Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Resize with mainMod + alt + arrow keys
binde = $mainMod ALT, right, resizeactive, 25 0
binde = $mainMod ALT, left, resizeactive, -25 0
binde = $mainMod ALT, up, resizeactive, 0 -25
binde = $mainMod ALT, down, resizeactive, 0 25

# Move windows around screen - to corners
binde = $mainMod SHIFT, left, moveactive, left
binde = $mainMod SHIFT, right, moveactive, r
binde = $mainMod SHIFT, up, moveactive, u
binde = $mainMod SHIFT, down, moveactive, d

# Move windows around screen
binde = $mainMod CTRL, left, moveactive, -50 0 
binde = $mainMod CTRL, right, moveactive, 50 0
binde = $mainMod CTRL, up, moveactive, 0 -50
binde = $mainMod CTRL, down, moveactive, 0 50

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with SPACE
binde = $mainMod, SPACE, workspace, e+1
binde = $mainMod ALT, SPACE, workspace, e-1

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Laptop multimedia keys for volume and LCD brightness
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

# Requires playerctl
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

# to switch between windows in a floating workspace
bind = SUPER, Tab, cyclenext,           # change focus to another window
bind = SUPER, Tab, bringactivetotop,    # bring it to the top

# Colored terminal launches / themes
bind = $mainMod, T, submap, themes
submap = themes
bind = , D, exec, ~/Scripts/terminal-mgmt/ColorTerm.sh dark
bind = , L, exec, ~/Scripts/terminal-mgmt/ColorTerm.sh light
bind = , K, exec, ~/Scripts/terminal-mgmt/KittyTheme.sh
bind = , G, exec, ghostty
bind = $mainMod, Z, submap, reset  # Exit themes submap


# Switch to 'resize' submap
bind = $mainMod, L, submap, resize
submap = resize

# Keep mappings for movefocus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

binde = $mainMod ALT, right, moveactive, 100 0
binde = $mainMod ALT, left, moveactive, -100 0
binde = $mainMod ALT, up, moveactive, 0 -80
binde = $mainMod ALT, down, moveactive, 0 80

binde = $mainMod CTRL, right, resizeactive, 50 0  
binde = $mainMod CTRL, left, resizeactive, -50 0
binde = $mainMod CTRL, up, resizeactive, 0 -50
binde = $mainMod CTRL, down, resizeactive, 0 50

binde = $mainMod SHIFT, right, resizeactive, 100 0
binde = $mainMod SHIFT, left, resizeactive, -100 0
binde = $mainMod SHIFT, up, resizeactive, 0 -100
binde = $mainMod SHIFT, down, resizeactive, 0 100

bind = $mainMod, Z, submap, reset
submap = reset

bind = $mainMod ALT, Y, submap, scripts
submap = scripts


# Quick backup key
bind = , B, exec, ~/Scripts/file-mgmt/QuickBackup.sh

# Upload system files script
bind = , U, exec, ~/Scripts/file-mgmt/upload-sysfiles.sh

# Notes management
bind = , N, exec, ~/Scripts/notes.sh mynote
bind = SHIFT, N, exec, ~/Scripts/notes.sh newnote

# Kitty themes script (fzf selector)
bind = , T, exec, ~/scripts/kittytheme.sh

# Screenshot tool
bind = , P, exec, ~/Scripts/utility/screenshot.sh

# Custom terminal themes
bind = , C, exec, ~/Scripts/terminal-mgmt/ColorTerm.sh dark
bind = SHIFT, C, exec, ~/Scripts/terminal-mgmt/ColorTerm.sh light

# Random terminal themes
bind = , R, exec, ~/Scripts/terminal-mgmt/ctRandom.sh dark
bind = SHIFT, R, exec, ~/Scripts/terminal-mgmt/ctRandom.sh light

# Keybind Reference Guide
bind = , K, exec, ~/Scripts/utility/KeybindReference.sh

bind = $mainMod SHIFT, R, exec, hyprctl reload
bind = $mainMod ALT, R, exec, reboot

# Exit 'scripts' submap
bind = $mainMod, Z, submap, reset
submap = reset



##############################
### WINDOWS AND WORKSPACES ###
##############################

# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
# See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

# Example windowrule v1
# windowrule = float, ^(kitty)$

# Waybar Small Terminal Instance
windowrulev2 = float, title:wayterm
windowrulev2 = size 369 50, title:wayterm
windowrulev2 = move 995 716, title:wayterm
windowrulev2 = pin, float, title:wayterm
windowrulev2 = rounding 10, title:wayterm
windowrulev2 = noinitialfocus, title:wayterm
windowrulev2 = bordersize 0, title:wayterm
windowrulev2 = decorate [on], title:wayterm
windowrulev2 = noborder [on], title:wayterm
windowrulev2 = opacity [0.8], title:wayterm
windowrulev2 = xray [on], title:wayterm
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

# Ignore maximize requests from apps. You'll probably like this.
windowrulev2 = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland,
windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0



- [config](#section-9)

## config
<a id="section-9"></a>

{
    "position": "bottom",
    "height": 40,
    "style": "style.css",
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-right": ["custom/terminal"],
    "modules-center": [
        "pulseaudio",
        "network",
        "backlight",
        "battery",
        "cpu",
        "memory",
        "tray"
    ],
    "hyprland/workspaces": {
        "disable-scroll": false,
        "enable-shortnames": true,
        "strip-wl": true
    },
    "custom/gmail": {
        "exec": "~/Scripts/waybar/custom-gmail.sh",
        "interval": 300,
        "return-type": "json",
        "on-click": "exec ~/Projects/OpenAI/GPTMail/main.py"
    },
    "custom/terminal": {
        "format": "wayterm 󰨊",
        "on-click": "kitty -T wayterm -c ~/.config/kitty/wayterm.conf -e bash",
        "tooltip": "Wayterm"
    },
    "custom/cpu_temp": {
        "exec": "~/Scripts/waybar/cpu-temp.sh",
        "interval": 15,
        "return-type": "json",
        "format": "󰔏 ICON BANK  󰴷  ",
        "tooltip": "cpu temperature"
    },
    "tray": {
        "spacing": 10
    },
    "clock": {
        "format": "󰀠 {:%I:%M %p}",
        "format-alt": " {:%m-%d-%Y}",
        "tooltip": "clock"
    },
    "cpu": {
        "format": "{icon}",
        "format-alt": "󰊠 CPU: {usage}%",
        "tooltip": "cpu usage",
        "on-click": "waybar-msg action toggle-format cpu",
        "format-icons": ["", "", "󰛕", "󱓈"],
        "states": {
            "low": 20,
            "moderate": 60,
            "high": 80
        }
    },
    "memory": {
        "format": "{icon}",
        "format-alt": " RAM: {used}Gb of {total}Gb",
        "tooltip": "memory usage",
        "on-click": "waybar-msg action toggle-format memory",
        "format-icons": ["", "󰛕", "󰐸"], 
        "states": {
            "low": 30,
            "moderate": 70,
            "high": 90
        }
    },
    "backlight": {
        "format": "{icon}",
        "format-alt": "Brightness: {percent}%",
        "format-icons": ["", "", ""],
        "tooltip": "backlight",
        "on-click": "waybar-msg action toggle-format backlight"
    },
    "network": {
        "format": "{icon}",
        "format-alt": "Wi-Fi: {essid} ({signalStrength}%)",
        "tooltip": "Network {essid}",
        "on-click": "waybar-msg action toggle-format network",
        "format-icons": [""]
    },
    "battery": {
        "format": "{icon}",
        "format-alt": "BAT: {capacity}%",
        "tooltip": "Battery",
        "on-click": "waybar-msg action toggle-format battery",
        "format-icons": ["", "", "", "", ""],
        "charging-format-icons": ["⚡", "", "🔌"],
        "states": {
            "critical": 15,
            "low": 30,
            "medium": 60,
            "high": 95
        }
    },
    "pulseaudio": {
        "format": "{icon}",
        "format-alt": "Speaker: {volume}%",
        "tooltip": "speakers",
        "on-click": "waybar-msg action toggle-format pulseaudio",
        "format-icons": ["", "", "", "", ""],
        "states": {
            "muted": true,
            "low": 0,
            "medium": 1,
            "high": 50
        }
    }
}




- [style.css](#section-10)

## style.css
<a id="section-10"></a>

@import "way_colors.css";

* {
  font-family: "Jetbrains Mono Nerd Font", monospace;
  font-size: 14px;
  min-height: 0;
}

/* Make the entire bar visible with a subtle background and rounded corners */
#waybar {
  background-color: @crust;
  color: @darkblue;
  margin: 1px;
  padding: 1px 1px;
  border-radius: 5px;
}

/* Add spacing between each module */
#waybar > * {
  margin: 2px 2px;
}

#custom-terminal {
  padding: 1rem 1rem;
  margin-right: 1.5rem;
  color: @maroon;
  font-size: 14px;
}

/* Increase font size for icons */
#waybar button, #waybar .icon {
  font-size: 56px/* Adjust this value to your preference */
}
#custom-gmail button:hover {
  color: @maroon;
  border-radius: 5px;
}

/* Workspaces styling */
#workspaces {
  color: @mantle;
  border-radius: 1px;
  margin: 1px;
  background-color: @overlay0;
  margin-left: 1rem;
  margin-right: 1rem;
}

#workspaces button {
  color: @sapphire;
  border-radius: 0px;
  padding: 2px;
  background-color: @mantle;
}

#workspaces button.active {
  color: @crust;
  background-color: @sapphire;
  border-radius: 2px;
}

#workspaces button:hover {
  color: @maroon;
  border-radius: 5px;
}


/* All modules styling */
#pulseaudio,
#memory,
#backlight,
#clock,
#custom-cpu_temp,
#cpu,
#battery,
#network {
  background-color: @surface0;
  padding: 0.5rem 1rem;
  margin: 5px 0;
  border-radius: 0px;
}

/* Weather Module */
#custom-weather {
  color: @sky;
  background-color: @mantle;
  border-radius: 10px;
  padding: 5px 10px;
  margin: 5px;
  font-weight: bold;
}

#custom-weather:hover {
  background-color: @blue;
  color: @crust;
  transition: 0.3s;
}

/* Specific styles */
#clock {
  color: @blue;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
}

#backlight {
  color: @yellow;
}

#memory {
  color: @blue;
  margin-right: 1rem;
  border-radius: 0px 1rem 1rem 0px;
}

#pulseaudio {
  color: @blue;
  margin-left: 1rem;
  border-radius: 1rem 0px 0px 1rem;
}



- [libinput-gestures.conf](#section-11)

## libinput-gestures.conf
<a id="section-11"></a>

# Configuration file for libinput-gestures.
# Mark Blakeney, Sep 2015
#
# The default configuration file exists at /etc/libinput-gestures.conf
# but a user can create a personal custom configuration file at
# ~/.config/libinput-gestures.conf.
#
# Lines starting with '#' and blank lines are ignored. Currently
# "gesture" and "device" configuration keywords are supported as
# described below. The keyword can optionally be appended with a ":" (to
# maintain compatibility with original format configuration files).
#
# Each gesture line has 3 [or 4] arguments separated by whitespace:
#
# action motion [finger_count] command
#
# where action and motion is either:
#     swipe up
#     swipe down
#     swipe left
#     swipe right
#     swipe left_up
#     swipe left_down
#     swipe right_up
#     swipe right_down
#     pinch in
#     pinch out
#     pinch clockwise
#     pinch anticlockwise
#     hold on (hold gesture available since libinput 1.19)
#

# xdotool does not work with native Wayland clients.

###########################################################################
# Do maximize and fullscreen stuff
gesture swipe up 3 hyprctl dispatch fullscreen 1
gesture swipe down 3 hyprctl dispatch fullscreen 0
gesture pinch in 3 hyprctl dispatch togglefloating
gesture pinch out 3 hyprctl dispatch pseudo
# gesture swipe up 4 hyprctl dispatch fullscreen 0
# gesture swipe down 4 hyprctl dispatch fullscreen 0

# :split ~/.gesture swipe right 3 hyprctl dispatch layoutmsg cyclenext
# gesture swipe left 3 hyprctl dispatch layoutmsg cycleprev

gesture swipe up 4 kitty
gesture swipe down 4 hyprctl dispatch killactive
gesture hold on 4 hyprctl dispatch togglesplit
gesture hold on 3 hyprctl dispatch rofi -show drun rofi -show-drun

# Browser go forward (works only for Xorg, and Xwayland clients)
# gesture swipe left	xdotool key alt+Right

# Browser go back (works only for Xorg, and Xwayland clients)
# gesture swipe right	xdotool key alt+Left
# Example to change audio volume (this works on both Wayland and Xorg):
# Note each swipe only steps volume once.
# swipe up   4 amixer set Master "8%+"
# swipe down 4 amixer set Master "8%-"

###############################################################################
# PINCH GESTURES:
###############################################################################
gesture pinch in 2 hyprctl dispatch splitratio +0.5
gesture pinch out 2 hyprctl dispatch splitratio -0.5




- [init.lua](#section-12)

## init.lua
<a id="section-12"></a>

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")



- [kitty.conf](#section-13)

## kitty.conf
<a id="section-13"></a>

# Font Settings
# font_family JetBrains Mono Nerd
font_size 8.0
# bold_font auto
# italic_font auto

# Color Theme
# background #282c34
# foreground #abb2bf
# cursor     #528bff
# selection_background #3e4451
# selection_foreground #ffffff

# Window Layout
tab_bar_edge top
enable_audio_bell no
hide_window_decorations no

# Keybindings
map ctrl+shift+enter new_window
map ctrl+shift+t     new_tab
map ctrl+shift+w     close_window
map ctrl+shift+n     next_layout
map ctrl+shift+n     reload_config

# Scrollback
scrollback_lines 10000

# Shell (default to your Arch setup)
shell /bin/bash

# Miscellaneous
allow_remote_control yes
bell_on_tab yes



# BEGIN_KITTY_THEME
# bl1nk
include current-theme.conf
# END_KITTY_THEME

# BEGIN_KITTY_FONTS
font_family      family="JetBrainsMono Nerd Font Mono"
bold_font        auto
italic_font      auto
bold_italic_font auto
# END_KITTY_FONTS


- [pacman-installs.txt](#section-14)

## pacman-installs.txt
<a id="section-14"></a>

alsa-utils
arp-scan
barrier
base
base-devel
bash-completion
blueman
bluez
bluez-utils
brightnessctl
btop
cellwriter
chatgpt-desktop-bin
cifs-utils
cliphist
cmake
cockpit
cpupower
ctop
darktable
deskflow
docker
docker-compose
dolphin
dos2unix
dosfstools
dunst
efibootmgr
eza
falkon
feh
firefox
flameshot
font-manager
foot
fuse2
fzf
gammastep
gcc
geckodriver
gesture-manager-git
ghostty
git
glfw
glow
grafana
grim
grit
grub
gtk-vnc
gvim
httpie
hyprland
hyprland-qtutils
hyprlock
hyprpaper
hyprpicker
hyprshot-git
hyprsysteminfo
i2pd
imagemagick
inxi
isync
jellyfin-server
jellyfin-web
jq
kitty
krita
less
libinput-gestures
linux
linux-firmware
lsof
make
mako
mopidy
mosh
mpv
msmtp
nano
ncdu
ncspot-bin
neofetch
neovim
networkmanager
nfs-utils
ngrep
nmap
npm
openssh
openvpn
pamixer
paru-bin
patch
pavucontrol
pipewire
pipewire-alsa
pipewire-pulse
pkgconf
power-profiles-daemon
powertop
prometheus
putty
pyenv
qbittorrent-nox
qt5-wayland
qt5-webengine
qt6-wayland
remmina
ripcord
rofi
rofi-emoji
simplescreenrecorder
slurp
smbclient
socat
sqlitebrowser
sshfs
sshpass
sudo
sway
swaybg
swaylock-effects
swaync
tcpdump
termshark
ticker
tigervnc
timeshift
tk
tmux
tor
tor-browser-alpha-bin
torsocks
tree
ttf-cascadia-code
ttf-fira-code
ttf-font-awesome
ttf-ibmplex-mono-nerd
ttf-jetbrains-mono-nerd
ttf-maple-beta
ttf-maple-beta-nf
ttf-maple-beta-nf-cn
ttf-material-design-icons-webfont
ttf-roboto-mono
tumbler
unzip
upscayl-bin
usbip
vulkan-intel
wacom-settings-git
wacomtablet
wakeonlan
waybar
wayland-protocols
wayland-utils
waylock
waynergy
wayvnc
wget
wireguard-tools
wireless-regdb
wireplumber
wl-clipboard
wlroots
wmctrl
wtype
xclip
xdotool
xf86-input-wacom
xf86-video-intel
xorg-server
xournalpp
yay
yay-debug
ydotool
yetris
zram-generator
zsh

=== System Information (inxi -Fxz) ===

System:
  Kernel: 6.14.1-arch1-1 arch: x86_64 bits: 64 compiler: gcc v: 14.2.1
  Desktop: Hyprland v: 0.48.1 Distro: Arch Linux
Machine:
  Type: Laptop System: LENOVO product: 82V6 v: IdeaPad 1 14IGL7
    serial: <superuser required>
  Mobo: LENOVO model: LNVNB161216 v: SDK0T76477 WIN
    serial: <superuser required> UEFI: LENOVO v: KKCN23WW date: 03/29/2024
Battery:
  ID-1: BAT0 charge: 36.6 Wh (89.5%) condition: 40.9/42.0 Wh (97.5%)
    volts: 12.2 min: 11.2 model: Sunwoda L21D3PF0 status: discharging
  Device-1: apple_mfi_fastcharge model: N/A charge: N/A status: N/A
CPU:
  Info: dual core model: Intel Celeron N4020 bits: 64 type: MCP
    arch: Goldmont Plus rev: 8 cache: L1: 112 KiB L2: 4 MiB
  Speed (MHz): avg: 1580 min/max: 800/2800 cores: 1: 1580 2: 1580
    bogomips: 4377
  Flags: ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel GeminiLake [UHD Graphics 600] vendor: Lenovo driver: i915
    v: kernel arch: Gen-9.5 bus-ID: 00:02.0
  Device-2: IMC Networks Integrated Camera driver: uvcvideo type: USB
    bus-ID: 1-7:3
  Display: wayland server: X.org v: 1.21.1.16 with: Xwayland v: 24.1.6
    compositor: Hyprland v: 0.48.1 driver: gpu: i915
    resolution: no compositor data resolution: 1366x768
  API: EGL Message: EGL data requires eglinfo. Check --recommends.
  Info: Tools: wl: swaymsg,wayland-info x11: xprop
Audio:
  Device-1: Intel Celeron/Pentium Silver Processor High Definition Audio
    vendor: Lenovo driver: snd_hda_intel v: kernel bus-ID: 00:0e.0
  API: ALSA v: k6.14.1-arch1-1 status: kernel-api
  Server-1: sndiod v: N/A status: off
  Server-2: PipeWire v: 1.4.1 status: active
Network:
  Device-1: Realtek RTL8852BE PCIe 802.11ax Wireless Network vendor: Lenovo
    driver: rtw89_8852be v: kernel port: 1000 bus-ID: 03:00.0
  IF: wlp3s0 state: up mac: <filter>
  IF-ID-1: br-63615dd31ca3 state: down mac: <filter>
  IF-ID-2: br-a76143f9e7bd state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-3: br-e76bed31d799 state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-4: br-ed3f0d75a166 state: down mac: <filter>
  IF-ID-5: docker0 state: down mac: <filter>
  IF-ID-6: veth1b27660 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-7: veth67cecef state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-8: vethf560f2e state: up speed: 10000 Mbps duplex: full
    mac: <filter>
Bluetooth:
  Device-1: Realtek Bluetooth Radio driver: btusb v: 0.8 type: USB
    bus-ID: 1-3:2
  Report: btmgmt ID: hci0 rfk-id: 5 state: up address: <filter> bt-v: 5.2
    lmp-v: 11
Drives:
  Local Storage: total: 116.5 GiB used: 86.01 GiB (73.8%)
  ID-1: /dev/mmcblk1 model: MMC128 size: 116.5 GiB type: Removable
Partition:
  ID-1: / size: 113.62 GiB used: 85.85 GiB (75.6%) fs: ext4
    dev: /dev/mmcblk1p2
  ID-2: /boot size: 511 MiB used: 158 MiB (30.9%) fs: vfat
    dev: /dev/mmcblk1p1
Swap:
  ID-1: swap-1 type: file size: 2 GiB used: 0 KiB (0.0%) file: /swapfile
  ID-2: swap-2 type: zram size: 1.69 GiB used: 1.31 GiB (77.4%)
    dev: /dev/zram0
Sensors:
  System Temperatures: cpu: 37.0 C mobo: N/A
  Fan Speeds (rpm): N/A
Info:
  Memory: total: 4 GiB note: est. available: 3.38 GiB used: 2.76 GiB (81.5%)
  Processes: 233 Uptime: 2d 4h 55m Init: systemd
  Packages: 1020 Compilers: gcc: 14.2.1 Shell: system-info.sh inxi: 3.3.37

=== Memory Information (free -h) ===

               total        used        free      shared  buff/cache   available
Mem:           3.4Gi       2.7Gi       221Mi       491Mi       1.2Gi       657Mi
Swap:          3.7Gi       1.3Gi       2.4Gi

=== Disk Usage (df -h) ===

Filesystem      Size  Used Avail Use% Mounted on
dev             1.7G     0  1.7G   0% /dev
run             1.7G  1.6M  1.7G   1% /run
efivarfs         16E     0 -5.1K   0% /sys/firmware/efi/efivars
/dev/mmcblk1p2  114G   86G   22G  80% /
tmpfs           1.7G  484K  1.7G   1% /dev/shm
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
tmpfs           1.7G  5.1M  1.7G   1% /tmp
/dev/mmcblk1p1  511M  159M  353M  31% /boot
tmpfs           1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
tmpfs           347M  4.1M  343M   2% /run/user/1000

=== Wayland Session Variables ===

WAYLAND_DISPLAY=wayland-1
MOZ_ENABLE_WAYLAND=1



- [.gitconfig](#section-15)

## .gitconfig
<a id="section-15"></a>

[user]
	name = braydio
	email = chaffee.brayden@gmail.com
	password = Remington0323
[init]
	defaultBranch = main
[url "git@github.com:"]
	insteadOf = https://github.com/
[url "git@github"]
	cominsteadOf = https://github.com/



- [.mbsyncrc](#section-16)

## .mbsyncrc
<a id="section-16"></a>

# Global Options
SyncState *  # Sync read/unread status and other IMAP metadata globally

# IMAP Account Settings
IMAPAccount gmail
Host imap.gmail.com
User chaffee.brayden@gmail.com
Pass humuterkwxonvjgv 
TLSType IMAPS
AuthMechs LOGIN
PipelineDepth 2  # Improves sync speed by allowing more parallel requests

# Remote IMAP Store
IMAPStore gmail-remote
Account gmail

# Local Maildir Store
MaildirStore gmail-local
Path ~/.mail/Gmail/
Inbox ~/.mail/Gmail/Inbox/
SubFolders Verbatim  # Ensures correct handling of Gmail's folder structure

# Sync Channel for Main Inbox
Channel gmail-main
Far :gmail-remote:"INBOX"
Near :gmail-local:"Inbox"
Create Both
Expunge Both
Sync Pull

Channel gmail-all
Far :gmail-remote:"[Gmail]/All Mail"
Near :gmail-local:"Inbox"
Create Both
Expunge Both
Sync Pull

Channel gmail-trash
Far :gmail-remote:"[Gmail]/Trash"
Near :gmail-local:"Trash"
Patterns "[Gmail]/Trash"
Create Both
Expunge Both
Sync Push  # Only push local deletions, do not pull

# Group Gmail Channels
Group gmail
Channels gmail-main gmail-all gmail-trash



- [mimeapps.list](#section-17)

## mimeapps.list
<a id="section-17"></a>

[Default Applications]
inode/chardevice=thunar.desktop
application/octet-stream=vim.desktop
application/zip=thunar.desktop
application/vnd.appimage=com.mitchellh.ghostty.desktop

[Added Associations]
inode/chardevice=thunar.desktop;vim.desktop;
application/octet-stream=vim.desktop;thunar.desktop;
application/zip=thunar.desktop;file-roller.desktop;
application/vnd.appimage=com.mitchellh.ghostty.desktop;
image/jpeg=org.flameshot.Flameshot.desktop;
image/png=firefox.desktop;org.flameshot.Flameshot.desktop;timeshift-gtk.desktop;



