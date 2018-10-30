#!/usr/bin/env bash


menu_context() {
    contexts=(`kubectl config get-contexts | awk '{print $2}' | grep -v NAME`)
    
    PS3="set context: "
    select ctx in "${contexts[@]}"
    do
        printf '%s\n'
        set_context $ctx
        exit 0;
    done
}

menu_namespace() {
    current_context=`kubectl config current-context`
    namespaces=(`kubectl get ns | awk '{print $1}' | grep -v NAME`)

    PS3="set namespace for $current_context: "
    select ns in "${namespaces[@]}"
    do
        printf '%s\n'
        set_namespace $current_context $ns
        exit 0;
    done
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
