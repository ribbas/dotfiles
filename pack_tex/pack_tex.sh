#!/bin/zsh

# pack_tex
# 
# The lazy way to install Tex packages on Ubuntu machines without
# a Tex package manager
# 
# Usage:
#   ./pack_tex library_dir


sudo su

cp -r $1 $(kpsewhich -var-value TEXMFLOCAL)
$(which mktexlsr)
