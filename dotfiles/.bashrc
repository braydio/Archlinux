#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Functions

cds() {
    cd "$1" && ls -a --color=auto
}

vimhypr() {
    vim ~/.config/hypr/hyprland
}

dckrsa() {
    cd ~/projects/RevSplits/auto-rsa || {
        echo "Failed to navigate to ~/projects/RevSplits/auto-rsa"
        return 1
    }
    docker-compose up -d
}

newnote() {
    if [ -z "$1" ]; then
        echo "Usage: newnote <note_name> [notebook_directory]"
        return 1
    fi

    note_name="$1"
    if [ -n "$2" ]; then
        notebook_dir=~/Documents/"$2"
        mkdir -p "$notebook_dir" || {
            echo "Failed to create notebook directory: $notebook_dir"
            return 1
        }
        nano "$notebook_dir/$note_name.txt"
    else
        nano ~/Documents/"$note_name.txt"
    fi
}

mynote() {
    local docs_dir=~/Documents

    # Define colors
    local COLOR_NOTEBOOK="\033[1;34m"  # Blue for notebooks
    local COLOR_NOTE="\033[0;32m"      # Green for notes
    local COLOR_HEADER="\033[1;33m"    # Yellow for headers
    local RESET="\033[0m"              # Reset to default color

    # List all notebooks if no arguments are provided
    if [ -z "$1" ]; then
        echo -e "${COLOR_HEADER}Notebooks in $docs_dir:${RESET}"
        find "$docs_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | while read -r notebook; do
            echo -e "  ${COLOR_NOTEBOOK}${notebook}${RESET}"
        done
        return
    fi

    # If one argument, treat it as a notebook name and list notes
    if [ -n "$1" ] && [ -z "$2" ]; then
        local notebook="$docs_dir/$1"
        if [ -d "$notebook" ]; then
            echo -e "${COLOR_HEADER}Notes in $notebook:${RESET}"
            find "$notebook" -type f -exec basename {} \; | while read -r note; do
                echo -e "  ${COLOR_NOTE}${note}${RESET}"
            done
        else
            echo -e "${COLOR_HEADER}Notebook '${1}' does not exist.${RESET}"
        fi
        return
    fi

    # If two arguments, print the content of the specified note
    if [ -n "$1" ] && [ -n "$2" ]; then
        local notebook="$docs_dir/$1"
        local note="$notebook/$2"
        if [ -f "$note" ]; then
            echo -e "${COLOR_HEADER}Contents of ${COLOR_NOTE}${note}${RESET}:"
            cat "$note"
        else
            echo -e "${COLOR_HEADER}Note '${2}' does not exist in notebook '${1}'.${RESET}"
        fi
        return
    fi

    # Show usage instructions if the arguments are invalid
    echo -e "${COLOR_HEADER}Usage:${RESET}"
    echo -e "  ${COLOR_NOTEBOOK}mynote${RESET}                  - List all notebooks"
    echo -e "  ${COLOR_NOTEBOOK}mynote <notebook>${RESET}       - List all notes in a notebook"
    echo -e "  ${COLOR_NOTEBOOK}mynote <notebook> <note>${RESET} - Print the contents of a note"
}

# Aliases
alias spac='sudo pacman -S --needed'
alias avev='source .venv/bin/activate'
alias frfx='cd ~/projects/FyrFx'
alias notebooks='ls -lh ~/Documents'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PS1='[\u@\h \W]\$ '

