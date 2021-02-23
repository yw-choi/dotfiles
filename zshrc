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
bindkey -r "^L" 

# fzf configs
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CMD="fzf-tmux"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"
export FZF_DEFAULT_COMMAND="fd --type f --no-ignore --hidden --follow --exclude .git"
export FZF_PREVIEW_BAT='bat --style=numbers --color=always --line-range :500 {}'

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| ${FZF_CMD} --preview ${FZF_PREVIEW_BAT})}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(${FZF_CMD} --preview ${FZF_PREVIEW_BAT} --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(${FZF_CMD} --preview ${FZF_PREVIEW_BAT} --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
# fuzzy grep open via ag with line number
vg() {
  local file
  local line
  read -r file line <<<"$(rg --no-heading -n -i --ignore-file .git --no-ignore --no-messages $@ | ${FZF_CMD} --preview ${FZF_PREVIEW_BAT} -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}
gitroot() {
  local targetdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z ${targetdir} ]; then
    targetdir='./'
  fi  
  echo -n $targetdir
}


# z integration (recent dirs)
source ${HOME}/local/bin/z.sh
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | ${FZF_CMD} --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

_fzf_compgen_path() {
  fd --hidden --follow --no-ignore --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --no-ignore --follow --exclude ".git" . "$1"
}

export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
export FZF_CTRL_T_OPTS="--preview '${FZF_PREVIEW_BAT}'"
export FZF_ALT_C_COMMAND="fd --type d --exclude '.git' --no-ignore --hidden --follow"
# CTRL-P - Search files from git root directory and paste the selected file path(s) into the command line
__fsel_project() {
  local targetdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z ${targetdir} ]; then
    targetdir='./'
  fi  
  local cmd="${FZF_DEFAULT_COMMAND} . ${targetdir}"

  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) --preview ${FZF_PREVIEW_BAT} -m "$@" | while read item; do
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

