#!/usr/bin/env bash

echo "HOST: $SSH_USER@$SSH_HOST:$SSH_PORT"
echo "REMOTE PORT: $REMOTE_PORT"
echo "LOCAL PORT: $LOCAL_PORT"

exec autossh -tt -R $REMOTE_PORT:localhost:$LOCAL_PORT $SSH_USER@$SSH_HOST -p $SSH_PORT
