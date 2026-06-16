export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
#
# # eval "$(zoxide init zsh)"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# opencode
export PATH=/home/ak/.opencode/bin:$PATH


fj() {
  local job
  job=$(jobs -s | fzf | awk '{print $1}' | tr -d '[]')
  [ -n "$job" ] && fg %"$job"
}



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.odin:$PATH"

source <(fzf --zsh)

bindkey -v

# bun completions
[ -s "/home/ak/.bun/_bun" ] && source "/home/ak/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/home/ak/.deno/env"
