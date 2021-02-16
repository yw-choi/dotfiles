# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(fzf)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=vim
bindkey -v

# host-dependent configs
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "ywchoi.local" ]]; then
  source ~/.zshrc.local
elif [[ "$HOSTNAME" == "palm.yonsei.ac.kr" ]]; then
  source ~/.zshrc.palm
elif [[ "$HOSTNAME" = "login"* ]]; then
  source ~/.zshrc.nurion
fi

export PATH=~/local/bin:${PATH}

# common aliases
alias l='ls -l'
alias py=python
alias gp='git push origin'
alias gc='git commit -a -m'
alias ga='git add -f'
alias vimd="vim -c 'MarkdownPreview'"

# fzf configs
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type "bat" > /dev/null; then
  export PREVIEW_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
  export FZF_COMPLETION_OPTS="${PREVIEW_OPTS}"
fi

if type "rg" > /dev/null; then
  # using ripgrep combined with preview
  # find-in-file - usage: fif <searchTerm> <filepattern>
  fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages --hidden --glob "!.git/*" "$1" -g "$2" \
      | fzf --preview \
      "bat --style=numbers --color=always --line-range :500 {} \
      | rg \
        --colors 'match:none'\
        --colors 'match:bg:0x33,0x66,0xFF' \
        --colors 'match:fg:white' \
        --colors 'match:style:bold' \
        --ignore-case --pretty --context 10 '$1' \
      || rg --ignore-case --pretty --context 10 '$1' {}"
  }
  # fif and open with vim - usage: fo <searchTerm>
  fo() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    vim $(fif "$1" "$2")
  }
fi

# CTRL-P - Search files from git root directory and paste the selected file path(s) into the command line
__fsel_project() {
  local targetdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z ${targetdir} ]; then
    targetdir='./'
  fi  
  local cmd="${FZF_CTRL_T_COMMAND} . ${targetdir}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf-file-widget-project() {
  LBUFFER="${LBUFFER}$(__fsel_project)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-file-widget-project
bindkey '^P' fzf-file-widget-project

