#!/usr/bin/env bash

alias wo='tmux attach-session -t'
alias s='git status'
alias activate='source ./venv/bin/activate'

function create-session {
  PROJECTNAME=$1
  PROJECTDIR=${PROJECTDIR:=~/projects}
  mkdir -p $PROJECTDIR/$PROJECTNAME
  cd $PROJECTDIR/$PROJECTNAME
  tmux new -s $PROJECTNAME -n session -d
  tmux split-window -t $PROJECTNAME:0 -d
  tmux split-window -t $PROJECTNAME:0
  tmux attach -t $PROJECTNAME
}

function workon { 
  PROJECTNAME=$1
  tmux attach-session -t $PROJECTNAME > /dev/null
  if [[ $? -ne 0 ]]; then
    echo "Session $PROJECTNAME does not exist; creating"
    create-session $PROJECTNAME
  else
    tmux attach-session -t $PROJECTNAME
  fi
}

function search {
  egrep -r -n --color=always "$1" . 
}

function contextsearch {
  egrep  -T --color -r "$1" -A ${2:-5} -B ${2:-5}
}

function explorematches {
  egrep  -T --color=always -r "$1" -A ${2:-5} -B ${2:-5} | less -R
}

