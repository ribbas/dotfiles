#!/bin/sh
set -o errexit

py_dev () {
    # Python
    echo "Installing Python development tools..."
    sudo apt install python3.10 python3.10-venv python3-pip python3-dev -y
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
    sudo update-alternatives --set python /usr/bin/python3.10
}
