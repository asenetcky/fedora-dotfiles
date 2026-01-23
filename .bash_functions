# .bash_functions

# fedora silverblue function from their tips and tricks
# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/

function is_toolbox() {
    if [ -f "/run/.toolboxenv" ]
    then
        TOOLBOX_NAME=$(cat /run/.containerenv | grep -oP "(?<=name=\")[^\";]+")
        echo "[${HOSTNAME} ${TOOLBOX_NAME}]"
    fi
}

# export PS1="\[\e[31m\]\`is_toolbox\`\]\e[m\]\[\e[32m\]\\$ \[\e[m\]\[\e[37m\]❱\[\e[m\] "

function typst-compile() {
    # Check if a filename was provided
    if [ -z "$1" ]; then
        echo "Usage: typst-compile <file.typ>"
        return 1
    fi

    # Run the container
    podman run --rm \
        -v "$(pwd):/app:Z" \
        -w /app \
        ghcr.io/typst/typst \
        compile "$1"
}
