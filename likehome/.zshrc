HISTSIZE=2000 
SAVEHIST=2000 
HISTFILE=~/.cache/zsh-history
export PATH="/opt/bin:$PATH"
export LESSHISTFILE="$XDG_STATE_HOME"

#basic out tab completation
autoload -U compinit promptinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' menu select use-cache 1
zmodload zsh/complist
compinit
_comp_options+=(globdots) #includes dotfiles

#vi mode!!!
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
alias yt-dlp-archive="yt-dlp -f 'bv*[height=480]+ba' --merge-output-format mp4"
alias yt-dlp-mp3="yt-dlp -f 'ba' -x --audio-format=mp3"
alias yt-dlp-greshka="yt-dlp -f 'bv+ba' --merge-output-format mp4"
alias yt-dlp-music="yt-dlp --embed-metadata -f 'ba' -x --audio-format=flac"
alias ll="eza -lahF"
alias lt="eza -lahF -snew --reverse"
alias lr="eza -lhTF"
alias lm="eza -lahF --sort=size --reverse"
alias netstat-num="netstat -atu -epo --numeric-hosts --numeric-ports"
alias netstat-char="netstat -atu -epoW"
alias netstat-lis="netstat -tunlp"
alias last-im="last -adixw"
alias audacity-netless="firejail --noprofile --net=none audacity"
alias nightlight="xrandr --output eDP --brightness 0.3 && gammastep -l 90:90 -t 3500:3500"
alias vim="nvim"
alias neofetch="fastfetch"

alias normal-mode="doas -u martin cp /home/martin/.dotfiles/likehome/.xinitrc-normalno /home/martin/.dotfiles/likehome/.xinitrc; doas -u root rm -rf /etc/X11/xorg.conf; doas -u martin 'killall X && startx'"
# the above command puts you into normal mode, i.e. the igpu draws the screen and the dgpu can be used with prime-run command or in other ways
alias recording-mode="doas -u martin cp /home/martin/.dotfiles/likehome/.xinitrc-snimanje /home/martin/.dotfiles/likehome/.xinitrc; doas -u root nvidia-xconfig --prime; doas -u root killall X; doas -u martin startx"
# the above command puts you into recording mode where the screen is drawn by the dgpu
alias update-nvidia-patch="doas -u martin git clone https://github.com/keylase/nvidia-patch; cd nvidia-patch; su -c 'bash ./patch.sh && bash ./patch-fbc.sh && bash ./patch.sh -f && bash ./patch-fbc.sh -f'; cd .. ; rm -rf nvidia-patch"
# the above command installs a patch that enables NVENC and NvFBC for nvidia gpus automatically, must be run when the nvidia drivers are updated

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

source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh #dont touch

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

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[green]%}%n%{$fg[magenta]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} ψ%b "

. /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
