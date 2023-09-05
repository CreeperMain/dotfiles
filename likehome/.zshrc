HISTSIZE=2000 
SAVEHIST=2000 
HISTFILE=~/.cache/zsh-history

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

# Put your fun stuff here.

alias yt-dlp-mp4="yt-dlp -f 'bv*[height=1080]+ba' --merge-output-format mp4"
alias yt-dlp-mp3="yt-dlp -f 'ba' -x --audio-format=mp3"
alias ll="ls -lah --color=always"
alias lt="ls -laht --color=always"
alias lr="ls -lhR --color=always"

source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
#ova ne chepkaj go 
: ${ZSH_HIGHLIGHT_STYLES[acme:aurora]:=fg=green}

_zsh_highlight_highlighter_acme_paint() {
  # Colorize the whole buffer with the 'aurora' style
  _zsh_highlight_add_highlight 0 $#BUFFER acme:aurora
}
#ova go popravat bojata ^^^^^
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[green]%}%n%{$fg[magenta]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} ψ%b "