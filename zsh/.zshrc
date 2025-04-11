# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# cd -> zoxide
eval "$(zoxide init --cmd cd zsh)"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias vi='nvim'
alias vim='nvim'
alias py='/home/tobias/Vorlagen/python_ide.sh'
xhost +local:root > /dev/null 2>&1
alias projekt_manager='~/scripts/projekt_manager/projekt_manager.sh'
alias pm='~/scripts/projekt_manager/projekt_manager.sh'
alias tt=taskwarrior-tui
alias i3lock='i3lock --image ~/Pictures/Backgrounds/lock.png --scale'
alias lfc='/home/tobias/scripts/list_files_clipboard.sh'


export EDITOR=nvim
export VISUAL=nvim
alias zotero='/opt/zotero/zotero'
alias ovenv='source *env/bin/activate'
export BAT_THEME=gruvbox-light
alias snes='snes9x  -xvideo -maxaspect -xineramahead 1 -v8  -fullscreen'
fastfetch


