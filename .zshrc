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
alias julia='LD_LIBRARY_PATH="" JULIA_PKG_USE_CLI_GIT=true julia'
alias jlpkg='LD_LIBRARY_PATH="" JULIA_PKG_USE_CLI_GIT=true jlpkg'
alias pluto='MESA_LOADER_DRIVER_OVERRIDE=i965 julia --threads=auto -e "using Pluto; \
  Pluto.run(; launch_browser=false, require_secret_for_access=false)"'

#### Tmux ####
if [ ! -v DISABLE_ZSH_TMUX ] | [ ! "${DISABLE_ZSH_TMUX}" ]
then
    tmuxinator $TMUXINATOR_PROFILE
fi

# Starship #
eval "$(starship init zsh)"

#### Functions ####
aws-set () { export AWS_PROFILE=$1 }
clone-or-update () {
  if [[ $# -gt 2 ]]; then
    echo "Too many arguments."
    return 1
  elif [[ $# -lt 2 ]]; then
    echo "Must supply 2 arguments: repo and folder"
    return 1
  fi

  repo="$1"
  folder="$2"

  if [[ ! -d "$folder" ]]; then
    git clone "$repo" "$folder"
  else
    (cd "$folder" && git pull)
  fi
}

#### ZI ####

# OMZ Plugins #
zi snippet OMZL::history.zsh
zi wait'!' lucid light-mode for \
  OMZL::key-bindings.zsh

# History substring search #
zi light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax Highlighting #
zi ice atinit"zicompinit; zicdreplay" wait'!' lucid
zi light zsh-users/zsh-syntax-highlighting

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
