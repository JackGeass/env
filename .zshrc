#############################################
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#222222,bg=cyan,bold,underline"
export ZSH_DISABLE_COMPFIX=true
##############################################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#

#############################################
#
DEVTOOL_PATH=${HOME}/devtools
export PATH=${DEVTOOL_PATH}/anaconda3/bin:${PATH}
export PATH=${DEVTOOL_PATH}/go/bin:${PATH}
export PATH=${DEVTOOL_PATH}/bin:${PATH}
export PATH=${DEVTOOL_PATH}/nvim-linux64/bin:${PATH}
export PATH=${DEVTOOL_PATH}/node-v10.16.3-linux-x64/bin:${PATH}
alias vim=nvim
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export GOPATH=${DEVTOOL_PATH}/go.module
export GOBIN=${GOPATH}/bin


export DOCKER_TLS_VERIFY=1
#export DOCKER_HOST=tcp://192.168.99.100:2376
#export DOCKER_CERT_PATH=/mnt/c/Users/root/.minikube/certs
#export DOCKER_HOST=tcp://116.211.207.103:2376
export DOCKER_HOST=tcp://198.11.181.21:2376
export DOCKER_CERT_PATH=${HOME}/.docker
export DOCKER_CA_PATH=${HOME}/.docker/ca.pem
export DOCKER_KEY_PATH=${HOME}/.docker/key.pem
#export DISPLAY=:0
#export LIBGL_ALWAYS_INDIRECT=1
#HOST=tw06a1988v17

export PATH="$PATH:/mnt/d/home/onething/istio/istio-1.4.0/bin"


###########################################
#PS1='%$COLUMNS>╡>%F{cyan}╔╡%F{red}[%n]%F{cyan}:%F{yellow}[%m]%F{cyan}➾%F{green}[%~]%F{default}$PS1_GIT$(git_prompt_info)%F{cyan}${(l:COLUMNS::═:):-}%<<
#╚═╡%F{default}${ret_status} %{$reset_color%}'
#
#export PS1=''
export PROMPT='%$COLUMNS>╡>%F{cyan}╔╡%F{red}[%n]%F{cyan}:%F{yellow}[%m]%F{cyan}➾%F{green}[%~]%F{default}$PS1_GIT$(git_prompt_info)%F{cyan}${(l:COLUMNS::═:):-}%<<
╚═╡%F{default}${ret_status} %{$reset_color%}'
export PS1='%$COLUMNS>╡>%F{cyan}╔╡%F{red}[%n]%F{cyan}:%F{yellow}[%m]%F{cyan}➾%F{green}[%~]%F{default}$PS1_GIT$(git_prompt_info)%F{cyan}${(l:COLUMNS::═:):-}%<<
╚═╡%F{default}${ret_status} %{$reset_color%}'
if [ -z $TMUX ]; then
	source ${DEVTOOL_PATH}/extraterm-commands-0.43.0/setup_extraterm_zsh.zsh
fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


