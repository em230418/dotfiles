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
alias tb="nc eugenemolotov.ru 9999"

alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose run"
alias dc="docker-compose"

parse_git_branch() {
     git cb 2>/dev/null | sed -e 's/\(.*\)/(\1)/'
}

export PATH="$HOME/go/bin:$HOME/.config/composer/vendor/bin:$HOME/.npm-global/bin:$HOME/.cargo/bin:$PATH"
export NPM_CONFIG_PREFIX=~/.npm-global
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)\n\$ '

function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

