if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z-shell.pages.dev/docs/gallery/collection
zicompinit # <- https://z-shell.pages.dev/docs/gallery/collection#minimal
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://z-shell.pages.dev/docs/ecosystem/annexes
# examples here -> https://z-shell.pages.dev/docs/gallery/collection
zicompinit # <- https://z-shell.pages.dev/docs/gallery/collection#minimal
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes @molovo


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

#### Zellij  ####
if [ ! -v DISABLE_ZSH_ZELLIJ ] | [ ! "${DISABLE_ZSH_ZELLIJ}" ]
then
    cat "$HOME/.cache/wal/sequences"
    session_exists="$(zellij ls | grep default | wc -l)"
    if [[ $session_exists -eq 1 ]]
    then
        zellij a default
    else
        DISABLE_ZSH_ZELLIJ=1 zellij -l default.yml -s default
    fi
fi

# Starship #
eval "$(starship init zsh)"

#### Functions ####
source "$HOME/.zfuncs"

#### ZI ####

# OMZ Plugins #
zi snippet OMZL::history.zsh
zi wait'!' lucid light-mode for \
  OMZL::key-bindings.zsh

# Syntax Highlighting #
zi ice atinit"zicompinit; zicdreplay" wait'!' lucid
zi light zsh-users/zsh-syntax-highlighting

# History substring search #
zi light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# PyEnv #
zi ice atclone='clone-or-update git@github.com:pyenv/pyenv-virtualenv "$PWD/plugins/pyenv-virtualenv" && \
  clone-or-update git@github.com:aiguofer/pyenv-jupyter-kernel "$PWD/plugins/pyenv-jupyter-kernel"' \
  atinit='export PYENV_ROOT="$PWD"' atpull="%atclone" atload='export PYENV_VIRTUALENV_DISABLE_PROMPT=1; \
  eval "$(pyenv init --path)"; eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; \
  alias pyenv="CONFIG_OPTS=--enable-shared pyenv"' as='command' pick='bin/pyenv' nocompile='!' lucid
zi light pyenv/pyenv

# ASDF-VM #
zi ice atpull'zi creinstall -q "$PWD"' atinit'. "$PWD/asdf.sh"' as='command' pick='bin/asdf' lucid
zi light asdf-vm/asdf

# Poetry #
zi ice atclone='POETRY_HOME="$PWD" python ./install-poetry.py;
           "./bin/poetry" completions zsh > _poetry;
           zinit creinstall -q "$PWD"' \
           atpull="%atclone" atload='PATH+=":$PWD/bin"' \
           as='command' pick'bin/poetry' wait lucid
zi light python-poetry/poetry

# PyWal
cat "$HOME/.cache/wal/sequences" && clear
