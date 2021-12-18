# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ----- PROMPT_COMMAND
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWUPSTREAM="auto"
# GIT_PS1_SHOWCOLORHINTS=1
# GIT_PS1_SHOWSTASHSTATE=1
# PROMPT_COMMAND='__git_ps1'        # the nifty git branch thingy
# PROMPT_COMMAND='__git_ps1 "[ \$(date +%T) ] \u@\h:\w" "> "'

# source ~/git-prompt.sh
# unset PROMPT_COMMAND
# export PS1='\u@\h: \w$(__git_ps1 " (%s)")> '
# c_clear='\[\e[0m\]'
# c_cyan='\[\e[36m\]'
# kindalightblue=$(tput setaf 123)
# export PROMPT_COMMAND='history -a; __git_ps1 "${kindalightblue}\u${c_clear}@${kindalightblue}\h${c_clear} : ${c_cyan}\w${c_clear}" "> "'
