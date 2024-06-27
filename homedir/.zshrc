#package manager
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q
zstyle ':completion::complete:*' menu select use-cache 1
zmodload zsh/complist
_comp_options+=(globdots) #includes dotfiles in completion

#keybindings
bindkey '^y' autosuggest-accept
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
#bindkey '^s'

#history
HISTSIZE=5000 
SAVEHIST=5000 
HISTFILE=~/.cache/zsh-history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
export LESSHISTFILE="$XDG_STATE_HOME/.cache/"

#VI MODE!!!
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#aliases here
alias yt-dlp-mp4="yt-dlp -f 'bv*[height=1080]+ba' --merge-output-format mp4"
alias yt-dlp-archive="yt-dlp -f 'bv*[height=720]+ba' --merge-output-format mp4"
alias yt-dlp-mp3="yt-dlp -f 'ba' -x --audio-format=mp3"
alias yt-dlp-greshka="yt-dlp -f 'bv+ba' --merge-output-format mp4"
alias yt-dlp-music="yt-dlp --embed-metadata -f 'ba' -x --audio-format=flac"
alias ll="eza -lahF --sort=type"
alias lt="eza -lahF -snew --reverse"
alias lr="eza -lhTF --sort=type"
alias lm="eza -lahF --sort=size --reverse"
alias last-im="last -adixw"
alias nightlight="xrandr --output eDP --brightness 0.3 && gammastep -l 90:90 -t 3500:3500"
alias vim="nvim"
alias neofetch="fastfetch"
alias ollama="doas rc-service docker start && sleep 2 && docker start ollama && sleep 2 && docker exec -it ollama sh"
alias ollaoff="docker stop ollama && doas rc-service docker stop"

# snippets
#zinit snippet OMZP::sudo

#shell functions
comp-g++() { 
    g++ -o "${1%.*}" "$1"; 
}

zsh-reboot() {
    exec zsh
}

ff() { # find files it uses fzf 
    local dir="$1"
    local file=$(find "$dir" -type f | fzf-tmux -p --reverse --border=sharp --prompt '󰈞')
    local ext="${file##*.}"  # extract extension from the filename
    
    case "$ext" in
        jpg|jpeg|png|gif)
            viewnior "$file";;  # image viewer
        mp4|wav|mov)
            vlc "$file";; #vid viewer 
        *)
            nvim "$file";;  # default to nvim for other file types
    esac
}

ffd() { # find directories it uses fzf 
    local dir="$1"
    find "$dir" -type d | fzf-tmux -p --reverse --border=rounded --preview 'tree -C {}' | xargs nvim
}

countdown() {
    start="$(( $(date +%s) + $1))"
    while [ "$start" -ge $(date +%s) ]; do
        ## Is this more than 24h away?
        days="$(($(($(( $start - $(date +%s) )) * 1 )) / 86400))"
        time="$(( $start - `date +%s` ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

stopwatch() {
    start=$(date +%s)
    while true; do
        days="$(($(( $(date +%s) - $start )) / 86400))"
        time="$(( $(date +%s) - $start ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

#colors 4 syntax
ZSH_HIGHLIGHT_STYLES[precommand]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=green,underline
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=white

# Shell integrations
eval "$(fzf --zsh)" # ctrl r to pull it up rebind it somehow
eval "$(zoxide init --cmd cd zsh)"

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[green]%}%n%{$fg[magenta]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} ψ%b "
