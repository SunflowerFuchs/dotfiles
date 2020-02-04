#!/usr/bin/env bash

# run updates
echo "Running updates..."
sudo apt update > /dev/null 2>&1
sudo apt upgrade --yes > /dev/null 2>&1

dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
USER="${USER:-$(whoami)}"
HOME="${HOME:-~$USER}"

setupDirs() {
    LOCAL="${HOME}/.local/"
    newLocal=false
    if [[ ! -d "${LOCAL}" ]]; then
        newLocal=true
        mkdir "${LOCAL}"
    fi

    if $newLocal || [[ ! -d "${LOCAL}/bin/" ]]; then
        mkdir "${LOCAL}/bin/"
    fi
}

getCurl() {
    if [[ ! -x "$(command -v curl)" ]]; then
        echo "Installing curl..."
        sudo apt install --yes curl > /dev/null 2>&1
    fi
}

getTmux() {
    if [[ ! -x "$(command -v tmux)" ]]; then
        echo "Installing tmux..."
        sudo apt install --yes tmux > /dev/null 2>&1
    fi

    mkdir -p "${HOME}/.config/tmux-themes/"
    ln -s "${dotfiles}/tmux/magenta.tmuxtheme" "${HOME}/.config/tmux-themes/magenta.tmuxtheme"
    ln -s "${dotfiles}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
}

getMicro() {
    getCurl

    if [[ ! -x "$(command -v micro)" ]]; then
        echo "Installing micro..."
        # micro tries putting itself into the current folder, so i try to deal with ambiguity by switching to /tmp
        cd /tmp/
        curl -fsSLo /tmp/install.sh https://getmic.ro >/dev/null
        chmod u+x /tmp/install.sh
        /tmp/install.sh > /dev/null 2>&1
        rm /tmp/install.sh
        sudo mv /tmp/micro /usr/local/bin/micro
        cd "${dotfiles}"
    fi

    if [[ ! -x "$(command -v xsel)" ]]; then
        echo "Installing xsel for micro..."
        sudo apt install --yes xsel > /dev/null 2>&1
    fi

    if [[ ! -d "${HOME}/.config/micro/" ]]; then
        mkdir -p "${HOME}/.config/"
        ln -s "${dotfiles}/micro/" "${HOME}/.config/micro"
    fi
}

getZsh() {
    getCurl
    setupDirs

    new=false
    if [[ ! -x "$(command -v zsh)" ]]; then
        echo "Installing zsh..."
        new=true
        sudo apt install --yes zsh > /dev/null 2>&1
        sudo chsh -s "$(command -v zsh)" "${USER}"
    fi

    if $new || [[ ! -d "${HOME}/.oh-my-zsh/" ]]; then
        echo "Installing oh-my-zsh..."
        curl -fsSLo /tmp/install.sh "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" > /dev/null
        chmod u+x /tmp/install.sh
        /tmp/install.sh --unattended > /dev/null
        rm /tmp/install.sh
        echo 'export ZDOTDIR="${HOME}/.zsh"' > "${HOME}/.zshenv"
        echo '. "${ZDOTDIR}/.zshenv"' >> "${HOME}/.zshenv"
    fi

    ln -s "${dotfiles}/.zsh/" "${HOME}/.zsh"
    rm "${HOME}/.zshrc"
    ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
    ZDOTDIR="${HOME}/.zsh/"

    # installing the theme
    mkdir -p "${ZSH_CUSTOM}/themes/"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt" > /dev/null
    ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

    # adding plugins
    mkdir -p "${ZSH_CUSTOM}/plugins/"
    ln -s "${dotfiles}/.zsh/custom/plugins/ve/" "${ZSH_CUSTOM}/plugins/ve"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM}/plugins/zsh-completions" > /dev/null
    git clone https://github.com/zdharma/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" > /dev/null
    cp "${dotfiles}/.zsh/custom/fast-syntax-highlighting.theme" "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting/themes/custom.ini"


    if $new || [[ ! -x "$(command -v fzf)" ]]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null
        "${HOME}/.fzf/install" --no-update-rc --key-bindings --completion --no-bash --no-fish > /dev/null
        mv "${HOME}/.fzf.zsh" "${ZDOTDIR}/"
        mv "${HOME}/.fzf/bin/fzf" "${HOME}/.local/bin"
        mv "${HOME}/.fzf/bin/fzf-tmux" "${HOME}/.local/bin"
    fi
}

main() {
    getTmux
    getMicro
    getZsh
}

main
