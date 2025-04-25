# use powerline
#use_powerline="true"
# has weird character width
# example:
#    is not a diamond
has_widechars="false"
# source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# cd -> zoxide
eval "$(zoxide init --cmd cd zsh)"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in mb
alias more=less

alias vi='nvim'
alias vim='nvim'
alias wiki="vim +VimwikiIndex"

alias py='/home/tobias/vorlagen/python_ide.sh'
xhost +local:root > /dev/null 2>&1
alias projekt_manager='~/scripts/projekt_manager/projekt_manager.sh'
alias pm='~/scripts/projekt_manager/projekt_manager.sh'
alias tt=taskwarrior-tui
alias i3lock='i3lock --image ~/pictures/backgrounds/lock.png --scale'
alias lfc='/home/tobias/scripts/list_files_clipboard.sh'


export editor=nvim
export visual=nvim
alias zotero='/opt/zotero/zotero'
alias ovenv='source *env/bin/activate'
export bat_theme=gruvbox-light
alias snes='snes9x  -xvideo -maxaspect -xineramahead 1 -v8  -fullscreen'

#eval "$(starship init zsh)"
    tmux run-shell "$RESURRECT"

fastfetch


