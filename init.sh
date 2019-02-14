export PWD=`pwd`;

if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME=~/.config
fi

cp -R $PWD/.config $XDG_CONFIG_HOME
