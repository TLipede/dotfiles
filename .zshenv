#### System Exports ####
export PATH="$PATH:/snap/bin:$HOME/bin:$HOME/local/AppImage:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.0.0/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt:/usr/lib"
export EDITOR='kak'
export TERMINAL='st'
export XDG_CONFIG_HOME='$HOME/.config'


#### Config-related Exports ####
export AWS_CLI_AUTO_PROMPT='on-partial'
export AWS_PROFILE=dev

export IS_SERVER="$(
    if [[ -a "$HOME/.is_server" ]]; then
        echo true
    else
        echo false
    fi)"
export TMUXINATOR_PROFILE="$(
    if [[ "$IS_SERVER" == true ]]; then
        echo 'default-server'
    else
        echo 'default'
    fi)"
    

#### Folder Shortcuts ####
export repos="$HOME/Documents/Repositories"
export projects="$HOME/Documents/Projects"

#### User Exports ####
export JULIA_ARGS='LD_LIBRARY_PATH="" JULIA_PKG_USE_CLI_GIT=true MESA_LOADER_OVERRIDE=i965'
