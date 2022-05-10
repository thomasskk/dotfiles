# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/thomas/.oh-my-zsh"
export TERM=screen-256color

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

# other
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# z plugin
. ./z.sh

# starship prompt
eval "$(starship init zsh)"
