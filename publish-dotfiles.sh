#! /usr/bin/env bash
pushd ~/dotfiles
cp config.fish ~/.config/fish/
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore
cp init.vim ~/.config/nvim
popd
~/miniconda3/bin/conda init fish

