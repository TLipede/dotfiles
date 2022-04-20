### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

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
alias julia="$JULIA_ARGS julia"
alias juliatemp="$JULIA_ARGS julia --project=$(mktemp -d)"
alias jlpkg="$JULIA_ARGS jlpkg"
alias workstation="ENABLE_ZSH_ZELLIJ=1 ssh workstation"

#### Functions ####
source "$HOME/.zfuncs"

#### Zellij  ####
if [[ "${ENABLE_ZSH_ZELLIJ}" -eq 1 ]]; then
  zellij-default
fi

# Starship #
eval "$(starship init zsh)"

#### Zinit ####

# OMZ Plugins #
zinit snippet OMZL::history.zsh
zinit wait'!' lucid light-mode for \
  OMZL::key-bindings.zsh

# Syntax Highlighting #
zinit ice atinit"zicompinit; zicdreplay" wait'!' lucid
zinit light zsh-users/zsh-syntax-highlighting

# History substring search #
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# PyEnv #
zinit ice atclone='clone-or-update git@github.com:pyenv/pyenv-virtualenv "$PWD/plugins/pyenv-virtualenv" && \
  clone-or-update git@github.com:aiguofer/pyenv-jupyter-kernel "$PWD/plugins/pyenv-jupyter-kernel"' \
  atinit='export PYENV_ROOT="$PWD"' atpull="%atclone" atload='export PYENV_VIRTUALENV_DISABLE_PROMPT=1; \
  eval "$(pyenv init --path)"; eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; \
  alias pyenv="CONFIG_OPTS=--enable-shared pyenv"' as='command' pick='bin/pyenv' nocompile='!' lucid
zinit light pyenv/pyenv

# ASDF-VM #
zinit ice atpull'zinit creinstall -q "$PWD"' atinit'. "$PWD/asdf.sh"' as='command' pick='bin/asdf' lucid
zinit light asdf-vm/asdf

# Poetry #
zinit ice atclone='POETRY_HOME="$PWD" python ./install-poetry.py;
           "./bin/poetry" completions zsh > _poetry;
           zinit creinstall -q "$PWD"' \
           atpull="%atclone" atload='PATH+=":$PWD/bin"' \
           as='command' pick'bin/poetry' wait lucid
zinit light python-poetry/poetry

