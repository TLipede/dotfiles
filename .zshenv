#### System Exports ####
export PATH="$PATH:/snap/bin:$HOME/bin:$HOME/local/AppImage:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.0.0/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt:/usr/lib"
export EDITOR='kak'
export TERMINAL='alacritty'
export XDG_CONFIG_HOME="$HOME/.config"


#### Config-related Exports ####
export AWS_CLI_AUTO_PROMPT='on-partial'
export AWS_PROFILE=dev


#### Server Setup ####
export MACHINE_TYPE="$(
    if [[ -a "$HOME/.machine_type" ]]; then
        cat "$HOME/.machine_type"
    else
        echo "UNKNOWN"
    fi)"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export SESSION_TYPE=remote/ssh
# many other tests omitted
else
  case $(ps -o comm= -p "$PPID") in
    sshd|*/sshd) export SESSION_TYPE=remote/ssh;;
  esac
fi

export MACHINE_ID="$(
  if [[ ! -v MACHINE_ID ]]; then
    if [[ -a $HOME/.machineID ]]; then
      cat $HOME/.machineID
    else
      echo UNKNOWN
    fi
  else
    echo $MACHINE_ID
  fi)"

export ZELLIJ_DEFAULT_SESSION_NAME="$(
  if [[ $SESSION_TYPE == 'remote/ssh' ]]; then
    echo default-remote-$MACHINE_ID
  else
    echo default
  fi)"       

# TODO: Separate profile for notebook servers?
export ZELLIJ_DEFAULT_PROFILE=default.yml

#### Folder Shortcuts ####
export repos="$HOME/Documents/Repositories"
export projects="$HOME/Documents/Projects"

#### User Exports ####
export JULIA_ARGS='LD_LIBRARY_PATH="" JULIA_PKG_USE_CLI_GIT=true MESA_LOADER_OVERRIDE=i965'

