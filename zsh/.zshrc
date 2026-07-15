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
#if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#  source /usr/share/zsh/manjaro-zsh-prompt
#fi
setopt interactivecomments
# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export EDITOR=nvim
export VISUAL="$EDITOR"


# cd -> zoxide
eval "$(zoxide init --cmd cd zsh)"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in mb
alias more=less

alias vi='nvim'
alias vim='nvim'
alias wiki="vim +VimwikiIndex"

alias py='python'
xhost +local:root > /dev/null 2>&1
alias projekt_manager='~/scripts/projekt_manager/projekt_manager.sh'
alias pm='~/scripts/projekt_manager/projekt_manager.sh'
alias tt=taskwarrior-tui
alias i3lock='i3lock --image ~/pictures/backgrounds/lock.png --scale'
alias lfc='/home/tobias/scripts/list_files_clipboard.sh'


alias ovenv='source *env/bin/activate'
export bat_theme=gruvbox-light
alias snes='snes9x  -xvideo -maxaspect -xineramahead 1 -v8  -fullscreen'


tmux run-shell "$RESURRECT"

fastfetch
bindkey -v

eval "$(starship init zsh)"

# for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GPG/pass pinentry im Terminal
export GPG_TTY="$(tty)"
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
