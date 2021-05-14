#!/usr/bin/env bash

echo "$SSH_HOST:${SSH_PORT}"

mkdir -p ~/.ssh && ssh-keyscan -H -p $SSH_PORT $SSH_HOST >> ~/.ssh/known_hosts

echo "HOST: $SSH_USER@$SSH_HOST:$SSH_PORT"
echo "REMOTE PORT: $REMOTE_PORT"
echo "LOCAL PORT: $LOCAL_PORT"

cmd="autossh -tt"

echo "Ports to forward:"
IFS=';' read -ra _PORTS <<< "$PORTS"
j=0
for i in "${_PORTS[@]}"; do
  ((j=j+1))

  IFS=':' read -ra _PAIR <<< "$i"
  local_port=${_PAIR[0]}
  remote_port=${_PAIR[1]}
  echo "- #$j: $local_port -> $remote_port"

  cmd="$cmd -R$remote_port:localhost:$local_port"

done

cmd="$cmd $SSH_USER@$SSH_HOST -p $SSH_PORT"

echo $cmd
set -x

eval "exec $cmd"
