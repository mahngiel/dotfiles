
#CSS replacers
alias phdcss='while x=0; do lessc -x /Web/Sites/phd/public/less/styles.less > /Web/Sites/phd/public/css/style.css; sleep 2; done'
alias pushdw='sh /Web/Scripts/push_dw.sh'
alias pulldw='sh /Web/Scripts/pull_directwireless.sh'
alias pushphd='sh /Web/Scripts/rsync_publichd.sh'

#Git shorcuts
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

alias shutudown='sudo shutdown -h now'
alias reboot='sudo reboot'

#Dir shortcuts
alias esports='cd /Web/Sites/esports'
alias ownet='cd /Web/Sites/ownet'

#Autostart Tmux
if [[ ! $TERM =~ screen ]]; then 
   exec tmux 
fi

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
export PS1="\[\e[1;31m\][\[\e[m\]\[\e[0;1m\]${debian_chroot:+($debian_chroot)} \u\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \[\e[1;31m\]]\[\e[m\]\[\e[1;33m\][\[\e[m\]\[\e[1;33m\]\h\[\e[m\]\[\e[1;33m\]]\[\e[m\]\[\e[1;35m\] \[\e[m\]\[\e[1;35m\]\`parse_git_branch\`\[\e[m\]\[\e[1;35m\]\[\e[m\] "

#Composer
alias composer="php /Web/composer.phar "
