#!/usr/bin/env bash

# run updates
echo "Running updates..."
sudo apt update > /dev/null 2>&1
sudo apt upgrade --yes > /dev/null 2>&1

dotfiles="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

    mkdir -p "${HOME}/.config/tmux-themepack/powerline/custom/"
    ln -s "${dotfiles}/tmux/magenta.tmuxtheme" "${HOME}/.config/tmux-themepack/powerline/custom/magenta.tmuxtheme"
    ln -s "${dotfiles}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
    #ln -s "${dotfiles}/tmux/.tmuxinator.conf" "${HOME}/.tmuxinator.conf"
}

getMicro() {
    getCurl

    if [[ ! -x "$(command -v micro)" ]]; then
        echo "Installing micro..."
        curl -fsSLo /tmp/install.sh https://getmic.ro >/dev/null
        chmod u+x /tmp/install.sh
        /tmp/install.sh > /dev/null 2>&1
        rm /tmp/install.sh
        sudo mv micro/micro /usr/local/bin/micro
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

    new=false
    if [[ ! -x "$(command -v zsh)" ]]; then
        echo "Installing zsh..."
        new=true
        sudo apt install --yes zsh > /dev/null 2>&1
        sudo chsh -s "$(command -v zsh)" "${USER}"
    fi

    if $new || [[ ! -d "$(zsh -c 'echo $ZSH')" ]]; then
        echo "Installing oh-my-zsh..."
        curl -fsSLo /tmp/install.sh "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" > /dev/null
        chmod u+x /tmp/install.sh
        /tmp/install.sh --unattended > /dev/null
        rm /tmp/install.sh
        echo 'export ZDOTDIR="${HOME}/.zsh"' >> "${HOME}/.profile"
        echo 'ZDOTDIR="$HOME/.zsh"' > "${HOME}/.zshenv"
        echo '. "$ZDOTDIR/.zshenv"' >> "${HOME}/.zshenv"

    fi

    ln -s "${dotfiles}/.zsh/" "${HOME}/.zsh"
    ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

    # installing the theme
    mkdir "${ZSH_CUSTOM}/themes/"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt" > /dev/null
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

    # adding plugins
    mkdir "${ZSH_CUSTOM}/plugins/"
    ln -s "${dotfiles}/.zsh/custom/plugins/ve/" "${ZSH_CUSTOM}/plugins/ve"
    git clone https://github.com/zdharma/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" > /dev/null
}

main() {
    getTmux
    getMicro
    getZsh
}

main
