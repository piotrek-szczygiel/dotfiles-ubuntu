#!/bin/bash

ssh-add -l > /dev/null &2>1
if [[ $? != 0 ]]; then
    pkill socat
    if [[ -S $SSH_AUTH_SOCK ]]; then
        echo "Removing previous socket..."
        rm $SSH_AUTH_SOCK
    fi
    echo "Starting SSH-Agent relay..."
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi
