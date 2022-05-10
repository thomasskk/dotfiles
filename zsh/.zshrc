# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/thomas/.oh-my-zsh"

zstyle ':omz:update' mode reminder # just remind me to update when it's time
zstyle ':omz:update' frequency 13

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting yarn)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='mvim'
fi

# Set up aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias luamake=/home/thomas/lua-language-server/3rd/luamake/luamake
function acp() {
	git add .
	git commit -m "$1"
	git push
}
alias vi='nvim'
alias vim='nvim'
alias v='nvim'

alias lzg='lazygit'
alias lzd='lazydocker'

alias ls='exa'                 # just replace ls by exa and allow all other exa arguments
alias l='ls -lbF'              #   list, size, type
alias ll='ls -la'              # long, all
alias llm='ll --sort=modified' # list, long, sort by modification date
alias la='ls -lbhHigUmuSa'     # all list
alias lx='ls -lbhHigUmuSa@'    # all list and extended
alias tree='exa --tree'        # tree view
alias lS='exa -1'              # one column by just names

# other
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# z plugin
. $HOME/z.sh

# starship prompt
eval "$(starship init zsh)"
