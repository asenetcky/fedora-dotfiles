#!/bin/bash
# ls
alias ll='pls -a -d -d size'

# fedora toolbox
alias istoolbx='[ -f "/run/.toolboxenv" ] && grep -oP "(?<=name=\")[^"]+" /run/.containerenv'
# alias dev-base="toolbox enter dev-base"
# alias rlang="toolbox enter rlang"

# git
alias gst='git status -s'
alias gd='git diff'
alias gl='git log --oneline'
alias gc='git commit  -m'
alias gp='git push'
alias gpl='git pull'
#alias gsua='git submodule update --recursive --remote'
alias gsw='git switch'
alias gswc='git switch -c'
alias gcob='git branch | fzf | xargs git switch'
alias gbd='git branch -d'
alias lg='lazygit'
alias gb='git branch'
alias gba='git branch -a'

# marimo
alias mam="uvx marimo -y edit --sandbox --watch"

# easy open
alias open='xdg-open'
