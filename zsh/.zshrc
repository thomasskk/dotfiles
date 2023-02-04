# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/thomas/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/share/neovim/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
. ${HOME}/.env

source $HOME/.cargo/env 2>/dev/null

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
	export EDITOR='nvim'
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

alias yup='yarn upgrade-interactive'

# Allow Ctrl-z to toggle between suspend and resume
function Resume {
	fg
	zle push-input
	BUFFER=""
	zle accept-line
}
zle -N Resume
bindkey "^Z" Resume


# other
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

auto-switch-node-version() {
	NVMRC_PATH=$(nvm_find_nvmrc)
	CURRENT_NODE_VERSION=$(nvm version)

	if [[ ! -z "$NVMRC_PATH" ]]; then
		# .nvmrc file found!

		# Read the file
		REQUESTED_NODE_VERSION=$(cat $NVMRC_PATH)

		# Find an installed Node version that satisfies the .nvmrc
		MATCHED_NODE_VERSION=$(nvm_match_version $REQUESTED_NODE_VERSION)

		echo "$REQUESTED_NODE_VERSION"

		if [[ ! -z "$MATCHED_NODE_VERSION" && $MATCHED_NODE_VERSION != "N/A" ]]; then
			# A suitable version is already installed.

			# Clear any warning suppression
			unset AUTOSWITCH_NODE_SUPPRESS_WARNING

			# Switch to the matched version ONLY if necessary
			if [[ $CURRENT_NODE_VERSION != $MATCHED_NODE_VERSION ]]; then
				nvm use $REQUESTED_NODE_VERSION
			fi
		else
			# No installed Node version satisfies the .nvmrc.

			# Quit silently if we already just warned about this exact .nvmrc file, so you
			# only get spammed once while navigating around within a single project.
			if [[ $AUTOSWITCH_NODE_SUPPRESS_WARNING == $NVMRC_PATH ]]; then
				return
			fi

			# Convert the .nvmrc path to a relative one (if possible) for readability
			RELATIVE_NVMRC_PATH="$(realpath --relative-to=$(pwd) $NVMRC_PATH 2>/dev/null || echo $NVMRC_PATH)"

			# Print a clear warning message
			echo ""
			echo "WARNING"
			echo "  Found file: $RELATIVE_NVMRC_PATH"
			echo "  specifying: $REQUESTED_NODE_VERSION"
			echo "  ...but no installed Node version satisfies this."
			echo "  "
			echo "  Current node version: $CURRENT_NODE_VERSION"
			echo "  "
			echo "  You might want to run \"nvm install\""

			# Record that we already warned about this unsatisfiable .nvmrc file
			export AUTOSWITCH_NODE_SUPPRESS_WARNING=$NVMRC_PATH
		fi
	else
		# No .nvmrc file found.

		# Clear any warning suppression
		unset AUTOSWITCH_NODE_SUPPRESS_WARNING

		# Revert to default version, unless that's already the current version.
		if [[ $CURRENT_NODE_VERSION != $(nvm version default) ]]; then
			nvm use default
		fi
	fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto-switch-node-version
auto-switch-node-version

# z plugin
. $HOME/z.sh

# starship prompt
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/thomas/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
