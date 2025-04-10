# System Files

## Index

- [fstab](#section-1)

## fstab
<a id="section-1"></a>

# Static information about the filesystems.

# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
# /dev/nvme0n1p2
UUID=270e2f37-b985-41de-9434-496c91e9c5a4	/         	ext4      	rw,relatime	0 1


# # Storage at /dev/sda1
UUID=5fd96714-309b-4770-8cbd-dd0f4ddd84af /mnt/netstorage xfs defaults,noatime 0 2

# Export NAS Media


# Windows Share
//192.168.1.68/Shared /home/braydenchaffee/mnt/windows-share cifs credentials=/etc/smbcredentials/windows,uid=1000,gid=1000,iocharset=utf8 0 0

# Windows Jellyfin




- [hostname](#section-2)

## hostname
<a id="section-2"></a>

archdesk



- [hosts](#section-3)

## hosts
<a id="section-3"></a>

# Static table lookup for hostnames.
# See hosts(5) for details.



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
#VerbosePkgLists
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



- [.bashrc](#section-5)

## .bashrc
<a id="section-5"></a>

# ~/.bashrc
# Exit if not running interactively
[[ $- != *i* ]] && return

# Environment Variables
export TERM=xterm-256color
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export EDITOR=nvim

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

## Functions
cdr() {
  clear && cd "$1" && ls -a --color=auto
}

cds() {
  cd "$1" && ls -a --color=auto
}

cdc() {
  cd "$HOME/$1" && ls -a --color=auto
} # Because fuck a tilde (is that a tilde? Is that even how you spell it?)

# Git Aliases

# Prompt
PS1='\[\e[0;32m\][\u@\h \W]\$ \[\e[m\]'



- [hyprland.conf](#section-6)

## hyprland.conf
<a id="section-6"></a>


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

# For ArchDesk
monitor=DP-1, preferred, auto, auto

# For Arch Laptop
# monitor=eDP-1, preferred, auto, auto
# monitor=HDMI-A-1, preferred, auto-up, auto

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
exec-once = hyprpaper & mako
exec-once = # exec-once = qbittorrent


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
    gaps_out = 5
    gaps_in = 8
    border_size = 2
    resize_on_border = false
    allow_tearing = false
    layout = dwindle
    col.active_border = rgba(3f11abff) 
    col.inactive_border = rgba(a42ac1ff)
}

decoration {
    rounding = 0
    active_opacity = 1.0
    inactive_opacity = 0.8
    shadow {
        enabled = true
        range = 12
        render_power = 10
        color = rgba(56, 16, 156, 0.633)
    }
    blur {
        enabled = true
        size = 2
        passes = 3
        new_optimizations = true
        vibrancy = 15
    }
}



# https://wiki.hyprland.org/Configuring/Variables/#animations
animations {
    enabled = true # yes, please :)

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    bezier = overshot, 0.05, 0.9, 0.1, 1.1
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
workspace = w[tv1], gapsout:0, gapsin:0
workspace = f[1], gapsout:0, gapsin:0
windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

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
bind = $mainMod, C, exec, wl-copy
bind = $mainMod, M, exec, hyprctl reload 
bind = $mainMod, E, exec, dolphin
bind = $mainMod, F, fullscreen
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, Return, exec, kitty
bind = $mainMod SHIFT, Return, exec, ghostty
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, #dwindle

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

# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

windowrulev2 = float, class: kitty
windowrulev2 = size 600, 900 class: kitty
windowrulev2 = pseudotile, class: kitty

# Waybar Small Terminal Instance
windowrulev2 = float, title:wayterm
windowrulev2 = size 369 50, title:wayterm
windowrulev2 = move 995 716, title:wayterm
windowrulev2 = pin, float, title:wayterm
windowrulev2 = rounding 10, title:wayterm
windowrulev2 = noinitialfocus, title:wayterm
windowrulev2 = bordersize 0, title:wayterm
windowrulev2 = decorate [on], title:wayterm
windowrulev2 = noborder [on], title:wayte
windowrulev2 = opacity [0.8], title:wayterm
windowrulev2 = xray [on], title:wayterm

# Ignore maximize requests from apps. You'll probably like this.
windowrulev2 = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland,
windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0



- [config](#section-7)

## config
<a id="section-7"></a>

{
    "position": "bottom",
    "height": 40,
    "style": "style.css",
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-right": ["custom/terminal"],
    "modules-center": [
        "pulseaudio",
        "network",
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
        "format-icons": ["󱤐", "󱤐", "󱤐", "󱓈"],
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
    "network": {
        "format": "{icon}",
        "format-alt": "󱫋 ETH: {bandwidthDownBits}↓ {bandwidthUpBits}↑",
        "tooltip": "Network {essid}",
        "on-click": "waybar-msg action toggle-format network",
        "format-icons": ["󱫋"]
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




- [style.css](#section-8)

## style.css
<a id="section-8"></a>

@import "way_colors.css";

* {
  font-family: "Jetbrains Mono Nerd Font", monospace;
  font-size: 14px;
  min-height: 0;
}

/* Make the entire bar visible with a subtle background and rounded corners */
#waybar {
  background: rgba(40, 40, 50, 0.3); 
  color: @FFFFF;
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
  margin: 2px;
  color: @maroon;
  font-size: 14px;
  border: groove 2px;
  border-color: transparent;
}

#custom-terminal:hover {
  border-color: @peach;
}

/* Increase font size for icons */
#waybar button, #waybar .icon {
  font-size: 16px/* Adjust this value to your preference */
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
  border: groove 2px transparent;
  padding: 1px;
  background-color: @mantle;
}

#workspaces button.active {
  color: @crust;
  background-color: @sapphire;
  border-radius: 0px;
}

#workspaces button:hover {
  color: @maroon;
  border: groove 2px @mantle;
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
  color: @mantle;
  background-color: @teal;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
  font-weight: bold;
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



- [init.lua](#section-9)

## init.lua
<a id="section-9"></a>

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")



- [kitty.conf](#section-10)

## kitty.conf
<a id="section-10"></a>

# Font Settings
# font_family JetBrains Mono Nerd
font_size 9.0
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
# Base2Tone Morning Dark
include current-theme.conf
# END_KITTY_THEME

# BEGIN_KITTY_FONTS
font_family      family="Hurmit Nerd Font Mono"
bold_font        auto
italic_font      auto
bold_italic_font auto
# END_KITTY_FONTS



- [pacman-installs.txt](#section-11)

## pacman-installs.txt
<a id="section-11"></a>

alsa-oss
alsa-utils
barrier
base
base-devel
bash-completion
blas-openblas
bluez
bluez-utils
btop
cellwriter
chatgpt-desktop-bin
chrome-remote-desktop
clang
cmake
cockpit
cronie
ctop
cuda
discord-ptb
docker
docker-compose
dolphin
efibootmgr
eww
eza
fastfetch
firefox
font-manager
fzf
git
glow
grub
hyprland
hyprpaper
hyprshot
imagemagick
inxi
iotop
isync
jack2
jellycli
jellyfin-web
jre17-openjdk
kitty
krita
less
libspotify
linux
linux-firmware
lsof
mako
mesa-utils
meson
mopidy
mopidy-iris
mopidy-local
mopidy-scrobbler
mpv
msmtp
nano
ncdu
ncspot
neofetch
neovim
networkmanager
nfs-utils
nodejs
npm
nvidia
nvidia-container-toolkit
nvidia-settings
otf-hermit
otf-hermit-nerd
otf-openmoji
pnpm
putty
pyenv
python-huggingface-hub
python-pip
python-pipx
python-requests
qbittorrent-nox
qt6-tools
reflector
remote-desktop-manager
ripcord
rsync
rustdesk-bin
rustup
samba
smartmontools
spotify-tui
sshfs
sshpass
swaylock-effects
tigervnc
tmux
ttf-anonymous-pro
ttf-font-awesome
ttf-jetbrains-mono-nerd
ttf-maple-beta
ttf-maple-beta-nf
ttf-maple-beta-nf-cn
ttf-space-mono-nerd
unzip
usbip
usbutils
uv
vulkan-validation-layers
wacom-settings-git
waybar
waynergy
wayvnc
wget
whisparr-nightly-bin
wireguard-tools
wl-clipboard
wlroots
wmctrl
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-desktop-portal-hyprland
xf86-input-wacom
xfsprogs
xorg-xwayland
xorgxrdp-nvidia
xournalpp
xrdp
yarn
yay
yay-debug

=== System Information (inxi -Fxz) ===

System:
  Kernel: 6.13.8-arch1-1 arch: x86_64 bits: 64 compiler: gcc v: 14.2.1
  Desktop: Hyprland v: 0.48.1 Distro: Arch Linux
Machine:
  Type: Desktop Mobo: Gigabyte model: B550I AORUS PRO AX v: x.x
    serial: <superuser required> UEFI: American Megatrends LLC. v: FE
    date: 03/22/2024
CPU:
  Info: 8-core model: AMD Ryzen 7 5700X bits: 64 type: MT MCP arch: Zen 3+
    rev: 2 cache: L1: 512 KiB L2: 4 MiB L3: 32 MiB
  Speed (MHz): avg: 3593 min/max: 550/4663 boost: enabled cores: 1: 3593
    2: 3593 3: 3593 4: 3593 5: 3593 6: 3593 7: 3593 8: 3593 9: 3593 10: 3593
    11: 3593 12: 3593 13: 3593 14: 3593 15: 3593 16: 3593 bogomips: 108597
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3
Graphics:
  Device-1: NVIDIA TU116 [GeForce GTX 1650 SUPER] vendor: Gigabyte
    driver: nvidia v: 570.133.07 arch: Turing bus-ID: 06:00.0
  Display: wayland server: X.Org v: 24.1.6 with: Xwayland v: 24.1.6
    compositor: Hyprland v: 0.48.1 driver: gpu: nvidia,nvidia-nvswitch
    resolution: 2560x1080~60Hz
  API: EGL v: 1.5 drivers: nouveau,nvidia,swrast platforms:
    active: gbm,wayland,x11,surfaceless,device inactive: N/A
  API: OpenGL v: 4.6.0 compat-v: 4.5 vendor: nvidia mesa v: 570.133.07
    glx-v: 1.4 direct-render: yes renderer: NVIDIA GeForce GTX 1650
    SUPER/PCIe/SSE2
  Info: Tools: api: eglinfo,glxinfo gpu: nvidia-settings,nvidia-smi
    x11: xdpyinfo, xprop, xrandr
Audio:
  Device-1: NVIDIA TU116 High Definition Audio vendor: Gigabyte
    driver: snd_hda_intel v: kernel bus-ID: 06:00.1
  Device-2: Advanced Micro Devices [AMD] Starship/Matisse HD Audio
    vendor: Gigabyte driver: snd_hda_intel v: kernel bus-ID: 08:00.4
  API: ALSA v: k6.13.8-arch1-1 status: kernel-api
  Server-1: sndiod v: N/A status: off
  Server-2: JACK v: 1.9.22 status: off
  Server-3: PipeWire v: 1.4.1 status: active
Network:
  Device-1: Realtek RTL8125 2.5GbE vendor: Gigabyte driver: r8169 v: kernel
    port: e000 bus-ID: 04:00.0
  IF: eno1 state: up speed: 1000 Mbps duplex: full mac: <filter>
  Device-2: Realtek RTL8852CE PCIe 802.11ax Wireless Network
    driver: rtw89_8852ce v: kernel port: d000 bus-ID: 05:00.0
  IF: wlp5s0 state: up mac: <filter>
  IF-ID-1: br-17182bef1cf1 state: down mac: <filter>
  IF-ID-2: br-39c8e4bdf723 state: down mac: <filter>
  IF-ID-3: br-ae347f31d9a4 state: down mac: <filter>
  IF-ID-4: br-ba7880d23fad state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-5: br-bc3b2e3a73b4 state: down mac: <filter>
  IF-ID-6: br-bdd1c454bcc2 state: down mac: <filter>
  IF-ID-7: br-bf4e45ee4582 state: down mac: <filter>
  IF-ID-8: br-c966073c9316 state: down mac: <filter>
  IF-ID-9: br-d3066f5efab7 state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-10: br-f51b57d8be93 state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-11: docker0 state: down mac: <filter>
  IF-ID-12: veth3bbbd7f state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-13: veth6cb2223 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-14: veth8d0f49a state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-15: vethf0e745c state: up speed: 10000 Mbps duplex: full
    mac: <filter>
Bluetooth:
  Device-1: Realtek Bluetooth Radio driver: btusb v: 0.8 type: USB
    bus-ID: 1-8:3
  Report: btmgmt ID: hci0 rfk-id: 0 state: up address: <filter> bt-v: 5.3
    lmp-v: 12
Drives:
  Local Storage: total: 11.82 TiB used: 733.74 GiB (6.1%)
  ID-1: /dev/nvme0n1 vendor: Samsung model: SSD 990 EVO Plus 1TB
    size: 931.51 GiB temp: 41.9 C
  ID-2: /dev/sda vendor: Seagate model: ST12000VN0007-2GS116 size: 10.91 TiB
Partition:
  ID-1: / size: 915.32 GiB used: 452.03 GiB (49.4%) fs: ext4
    dev: /dev/nvme0n1p2
Swap:
  Alert: No swap data was found.
Sensors:
  System Temperatures: cpu: 46.8 C mobo: 34.0 C
  Fan Speeds (rpm): N/A
Info:
  Memory: total: 32 GiB available: 31.26 GiB used: 11.31 GiB (36.2%)
  Processes: 641 Uptime: 4d 2h 27m Init: systemd
  Packages: 924 Compilers: clang: 19.1.7 gcc: 14.2.1 Shell: upload-sysfiles
    inxi: 3.3.37

=== Memory Information (free -h) ===

               total        used        free      shared  buff/cache   available
Mem:            31Gi        11Gi       756Mi        75Mi        19Gi        19Gi
Swap:             0B          0B          0B

=== Disk Usage (df -h) ===

Filesystem             Size  Used Avail Use% Mounted on
dev                     16G     0   16G   0% /dev
run                     16G  1.7M   16G   1% /run
efivarfs               128K   15K  109K  12% /sys/firmware/efi/efivars
/dev/nvme0n1p2         916G  453G  417G  53% /
tmpfs                   16G  344K   16G   1% /dev/shm
tmpfs                   16G   11M   16G   1% /tmp
tmpfs                  1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
/dev/sda1               11T  282G   11T   3% /mnt/netstorage
//192.168.1.68/Shared  111G  106G  4.7G  96% /home/braydenchaffee/mnt/windows-share
tmpfs                  1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
tmpfs                  3.2G   11M  3.2G   1% /run/user/1000

=== Wayland Session Variables ===

WAYLAND_DISPLAY=wayland-1
MOZ_ENABLE_WAYLAND=1



- [.gitconfig](#section-12)

## .gitconfig
<a id="section-12"></a>

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
[credential]
	helper = store



- [user-dirs.dirs](#section-13)

## user-dirs.dirs
<a id="section-13"></a>

# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you're
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
# 
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"



