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

alias y="mpv --ytdl-format 'bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]'"  # через нее смотрю ютуб
alias yd="youtube-dl --format 'bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]'"  # через нее скачиваю видосики с ютуба. Потом себе на телефон
alias auau='sudo apt-get update && sudo apt-get upgrade'  # надо регулярно обновляться
alias tb="nc termbin.com 9999"

export PATH="$HOME/.cargo/bin:$PATH"
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '