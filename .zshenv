#### System Exports ####
export PATH="$PATH:/snap/bin:/home/tlipede/bin:/home/tlipede/.local/AppImage:/home/tlipede/.cargo/bin:/home/tlipede/.local/share/gem/ruby/3.0.0/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt"
export EDITOR='kak'
export TERMINAL='st'
export XDG_CONFIG_HOME='/home/tlipede/.config'


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
export repos="/home/tlipede/Documents/Repositories"
export projects="/home/tlipede/Documents/Projects"
