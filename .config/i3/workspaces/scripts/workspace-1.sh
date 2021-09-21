#!/bin/zsh

unset I3SOCK


WKSPACE=$1
TERMCMD=$2
SYSMONITORCMD=$3
VISCMD=$4

i3-msg "workspace $WKSPACE; append_layout ~/.config/i3/workspaces/layouts/workspace-1.json"
i3-msg "workspace $WKSPACE; exec $TERMCMD" && unset I3SOCK
i3-msg "workspace $WKSPACE; exec $TERMCMD -e $SYSMONITORCMD" && unset I3SOCK
i3-msg "workspace $WKSPACE; exec $TERMCMD -e $VISCMD" && unset I3SOCK
