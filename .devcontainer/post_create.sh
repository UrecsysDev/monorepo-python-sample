#!/bin/bash
set -ex

##
## Create some aliases
##
echo 'alias ll="ls -alF"' >> "$HOME/.bashrc"
echo 'alias la="ls -A"' >> "$HOME/.bashrc"
echo 'alias l="ls -CF"' >> "$HOME/.bashrc"

# Convenience workspace directory for later use
WORKSPACE_DIR=$(pwd)

# Change some Poetry settings to better deal with working in a container
poetry config cache-dir "${WORKSPACE_DIR}/.cache"
poetry config virtualenvs.in-project true

# Install all dependencies
poetry install
python run_script.py install-all

# Install pre-commit and pre-push hooks
poetry run pre-commit install
poetry run pre-commit install --hook-type pre-push

echo "pre_create DONE!"