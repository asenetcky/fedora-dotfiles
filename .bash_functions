#!/bin/bash
# .bash_functions

# fedora silverblue function from their tips and tricks
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/

function is_toolbox() {
  if [ -f "/run/.toolboxenv" ]; then
    TOOLBOX_NAME=$(cat /run/.containerenv | grep -oP "(?<=name=\")[^\";]+")
    echo "[${HOSTNAME} ${TOOLBOX_NAME}]"
  fi
}

# export PS1="\[\e[31m\]\`is_toolbox\`\]\e[m\]\[\e[32m\]\\$ \[\e[m\]\[\e[37m\]❱\[\e[m\] "

# podman wrapper around typst
#function typst() {
#    podman run --rm -it \
#        -v "$(pwd):/app" \
#        -w /app \
#        ghcr.io/typst/typst \
#        "$@"
#}
