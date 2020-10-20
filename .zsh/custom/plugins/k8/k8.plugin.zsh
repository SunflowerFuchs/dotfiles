#!/usr/bin/env zsh

if (( $+commands[kubeadm] )); then
    __KUBEADM_COMPLETION_FILE="${ZSH_CACHE_DIR}/kubeadm_completion"

    if [[ ! -f $__KUBEADM_COMPLETION_FILE || ! -s $__KUBEADM_COMPLETION_FILE ]]; then
        kubeadm completion zsh >! $__KUBEADM_COMPLETION_FILE
    fi

    [[ -f $__KUBEADM_COMPLETION_FILE ]] && source $__KUBEADM_COMPLETION_FILE

    unset __KUBEADM_COMPLETION_FILE
fi

if (( $+commands[kubectl] )); then
    __KUBECTL_COMPLETION_FILE="${ZSH_CACHE_DIR}/kubectl_completion"

    if [[ ! -f $__KUBECTL_COMPLETION_FILE || ! -s $__KUBECTL_COMPLETION_FILE ]]; then
        kubectl completion zsh >! $__KUBECTL_COMPLETION_FILE
    fi

    [[ -f $__KUBECTL_COMPLETION_FILE ]] && source $__KUBECTL_COMPLETION_FILE

    unset __KUBECTL_COMPLETION_FILE
fi

if (( $+commands[minikube] )); then
    __MINIKUBE_COMPLETION_FILE="${ZSH_CACHE_DIR}/minikube_completion"

    if [[ ! -f $__MINIKUBE_COMPLETION_FILE || ! -s $__MINIKUBE_COMPLETION_FILE ]]; then
        minikube completion zsh >! $__MINIKUBE_COMPLETION_FILE
    fi

    [[ -f $__MINIKUBE_COMPLETION_FILE ]] && source $__MINIKUBE_COMPLETION_FILE

    unset __MINIKUBE_COMPLETION_FILE
fi
