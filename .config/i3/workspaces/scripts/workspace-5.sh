#!/bin/zsh

WKSPACE=$1

i3-msg "workspace $WKSPACE; append_layout ~/.config/i3/workspaces/layouts/workspace-5.json"
i3-msg "workspace $WKSPACE; exec unset I3SOCK && spotify --uri=open.spotify.com"
i3-msg "workspace $WKSPACE; exec unset I3SOCK && pavucontrol"
i3-msg "workspace $WKSPACE; exec unset I3SOCK && blueman-manager"
i3-msg "workspace $WKSPACE; exec unset I3SOCK && arandr"
sleep 0.5
