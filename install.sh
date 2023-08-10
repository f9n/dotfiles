#!/usr/bin/env bash

set -e

function install_homebrew() {
    if ! command -v brew > /dev/null 2>&1; then
        echo "[+] homebrew could not be found"
        echo "[+] Installing homebrew ..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "[+] homebrew already exists!"
    fi
}

function install_pipx() {
    if ! command -v pipx > /dev/null 2>&1; then
        echo "[+] pipx could not be found"
        echo "[+] Installing pipx ..."

        brew install pipx
        pipx ensurepath

        source ~/.bashrc
    else
        echo "[+] pipx already exists!"
    fi
}

function install_ansible_and_deps() {
    echo "[+] Install ansible and deps"
    pipx install --include-deps ansible
    echo "[+] Install ansible-galaxy requirements"
    ansible-galaxy install -r requirements.yaml
}

function run_bootstrap_playbook() {
    echo "[+] Run bootstrap playbook"
    ./bootstrap.yaml
}

function main() {
    install_homebrew
    install_pipx
    install_ansible_and_deps
    run_bootstrap_playbook
}

main
