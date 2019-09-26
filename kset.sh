#!/usr/bin/env bash


menu_context() {
    local ctx
    ctx=$(kubectl config get-contexts | sed 1d | awk '{print $2}' | fzf)

    [ -n "ctx" ] && set_context $ctx
}

menu_namespace() {
    current_context=`kubectl config current-context`
    local ns
    ns=$(kubectl get ns | sed 1d | awk '{print $1}' | fzf)
  
    [ -n "$ns" ] && set_namespace $current_context $ns
}

set_context() { kubectl config use-context $1; }

set_namespace() { kubectl config set-context $1 --namespace=$2; }

if [ "$1" = "c" ]; then
    menu_context;
elif [ "$1" = "n" ]; then
    menu_namespace
else 
    printf '%s\n' "Usage: $0 c for context or $0 n for namespace"
    exit 1;
fi
