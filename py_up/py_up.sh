#!/bin/zsh

mkdir $1
cd $1

virtualenv .venv
touch requirements.txt

cp ../env.py .
cp ../Makefile .

source .venv/bin/activate
pip install -U pip
