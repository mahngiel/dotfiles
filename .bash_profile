export PATH="$PATH:/opt/arcanist/bin"
source /opt/arcanist/resources/shell/bash-completion

# Git autocomplete
. ~/.git-completion.bash

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "*${BRANCH}${STAT}*"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

#Startup Welcomes
export PS1="\[\e[1;31m\]│\[\e[m\]\[\e[0;1m\]${debian_chroot:+($debian_chroot)} \u\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \[\e[1;31m\]]\[\e[m\]\[\e[1;33m\][\[\e[m\]\[\e[1;33m\]\h\[\e[m\]\[\e[1;33m\]]\[\e[m\]\[\e[1;35m\]\
\n\[\e[1;31m\]│ \[\e[m\]\[\e[1;35m\]\`parse_git_branch\`\[\e[m\]\[\e[1;35m\]\
\n\[\e[1;31m\]└─\[\e[m\]\[\e[1;35m\]\[\e[m\]⚡ "

#Server Logging
alias logphd='ssh root@217.23.2.104'

#Git shorcuts
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gam='git commit -am '
alias got='git '
alias get='git '

alias shutudown='sudo shutdown -h now'
alias reboot='sudo reboot'

#Dir shortcuts
alias phd=' cd /Web/Sites/PublicHD'

# Application shortcuts
alias artisan='php artisan'
alias migrate='php artisan migrate --env=local'
alias mapp='migrate application'
alias py=python

# Redis Shortcuts
alias redis.dv='redis /Web/Redis/DeviceVault.conf; redis /Web/Redis/Castle.conf'
alias rediscli.dv='redis-cli -a devicevault -p 1666'

alias redis.grizzly="redis /Web/Redis/Grizzly.conf"
alias rediscli.grizzly="redis-cli -a grizzly -p 1642"

alias redis.phd="redis /Web/Redis/Matador.conf"
alias rediscli.phd="redis-cli -a matador -p 3647"

alias redis.rb="redis /Web/Redis/Redbook.conf"
alias rediscli.rb="redis-cli -a redbook -p 2245"

alias redis.io='redis /Web/Redis/Grizzly.IO.conf'
alias rediscli.io='redis-cli -a vRpkQ04I14rwa1ST7Wx87i4y -p 1645'


alias update='sudo apt-get update && sudo apt-get upgrade'
alias cleanL4='composer dump-autoload && artisan clear-compiled && artisan optimize'

alias boxes='cd /Web/Boxes'
