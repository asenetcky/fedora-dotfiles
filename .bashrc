#!/bin/bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  # shellcheck source=.bash_aliases
  . ~/.bash_aliases
fi

# User specific environment
if ! [[ $PATH =~ $HOME/.local/bin:$HOME/bin: ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      # shellcheck source=/dev/null
      . "$rc"
    fi
  done
fi
unset rc

# 1Password SSH agent
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# opencode
if ! [[ $PATH =~ $HOME/.opencode/bin ]]; then
  export PATH="$HOME/.opencode/bin:$PATH"
fi

# Everything below is for interactive shells only, and is guarded so it
# doesn't error inside toolboxes or before the tools are installed.
[[ $- == *i* ]] || return

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null; then eval "$(fzf --bash)"; fi

if command -v fastfetch >/dev/null; then fastfetch; fi
