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

# set -o vi
bindkey -v
export PATH=~/local/bin:${PATH}
alias l='ls -l'
alias py=python
alias gp='git push origin master'
alias gc='git commit -a -m'
alias ga='git add -f'
alias vimd="vim -c 'MarkdownPreview'"
export EDITOR=vim

# host-dependent configs
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "ywchoi.local" ]]; then
  source ~/.zshrc.local
elif [[ "$HOSTNAME" == "palm.yonsei.ac.kr" ]]; then
  source ~/.zshrc.palm
elif [[ "$HOSTNAME" = "login"* ]]; then
  source ~/.zshrc.nurion
fi

if type "fd" > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f'
fi
PREVIEW_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fzfp="fzf ${PREVIEW_OPTS}"
export FZF_COMPLETION_OPTS="${PREVIEW_OPTS}"

if type "rg" > /dev/null; then
  # using ripgrep combined with preview
  # find-in-file - usage: fif <searchTerm>
  fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages --hidden --glob "!.git/*" "$1" \
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
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



