Installation
============

Instructions on how to configure these files as your zsh + prezto configuration.

First, you may want to delete the old zsh files
rm -i ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc

(Use this version to skip the prompts)
rm -i ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc


Then run this to set up the new files

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/custom/^*.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
