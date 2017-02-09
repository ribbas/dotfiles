#!/bin/zsh

# py_up
# 
# A simple and lazy way to set up Python projects. This script creates a
# virtualenv with either versions of Python interpreters, upgrades pip
# configurations and adds enviroment helper scripts and Makefiles
# 
# Usage:
#   ./py_up proj_name python_ver


mkdir $1
cd $1

if [ "$2" = "2" ]; then
    virtualenv .venv
elif [ "$2" = "3" ]; then
    virtualenv -p /usr/bin/python3 .venv3
fi

touch requirements.txt
cp ~/helper-scripts/py_up/env.py ~/helper-scripts/py_up/Makefile .

source .venv*/bin/activate
pip install -U pip
deactivate
