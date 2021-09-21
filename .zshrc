### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


######################
# User configuration #
######################

#### Aliases ####
alias startwebcam='( cd $repos/Linux-Fake-Background-Webcam && docker-compose start )'
alias stopwebcam='( cd $repos/Linux-Fake-Background-Webcam && docker-compose stop )'
alias tmux='tmux -2'
alias exa='exa --icons'
alias spython='python -m IPython'
alias pluto='MESA_LOADER_DRIVER_OVERRIDE=i965 julia --threads=auto -e "using Pluto; \
	Pluto.run(; launch_browser=false, require_secret_for_access=false)"'

#### Tmux ####
if [ ! -v DISABLE_ZSH_TMUX ] | [ ! "${DISABLE_ZSH_TMUX}" ]
then
    tmuxinator default
fi

#### Functions ####
aws-set () { export AWS_PROFILE=$1 }

#### Zinit ####

## Plugins ##

# Syntax Highlighting #
zinit ice atinit"zicompinit; zicdreplay" wait'!' lucid
zinit light zsh-users/zsh-syntax-highlighting

# History substring search #
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Completions #
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
autoload compinit
compinit

# OMZ Plugins #
zinit snippet OMZL::history.zsh
zinit wait'!' lucid light-mode for \
	OMZL::key-bindings.zsh


# Starship #
eval "$(starship init zsh)"

# Zoxide #
eval "$(zoxide init zsh)"

# PyEnv #
zinit ice atclone='git clone git@github.com:pyenv/pyenv-virtualenv \
    "$PWD/plugins/pyenv-virtualenv"' atinit='export PYENV_ROOT="$PWD"' atpull="%atclone" \
    atload='export PYENV_VIRTUALENV_DISABLE_PROMPT=1; eval "$(pyenv init --path)";  eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"; alias pyenv="CONFIG_OPTS=--enable-shared pyenv"' \
    as='command' pick='bin/pyenv' nocompile='!' wait lucid
zinit light pyenv/pyenv

# ASDF-VM #
zinit ice atpull'zinit creinstall -q "$PWD"' atinit'. $PWD/asdf.sh' \
    as='command' pick='bin/asdf' wait lucid
zinit light asdf-vm/asdf
 
# Poetry #
zplugin ice atclone='POETRY_HOME="$PWD" python ./install-poetry.py;
           "./bin/poetry" completions zsh > _poetry;
           zinit creinstall -q "$PWD"' \
           atpull="%atclone" atload='PATH+="$PWD/bin"' \
           as='command' pick'bin/poetry' wait lucid
zplugin light python-poetry/poetry
