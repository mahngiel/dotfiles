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

function __promptCommand() {
  local EXIT="$?"

  PS1=""

  [[ $EXIT > 0 ]] && PS1="\[\e[1;31m\]│\[\e[m\]" || PS1="\[\e[1;32m\]│\[\e[m\]" # Left |
  PS1="$PS1\[\e[0;1m\]${debian_chroot:+($debian_chroot)} \u\[\e[m\] " # username
  PS1="$PS1\[\e[1;36m\]\w\[\e[m\] " # working dir
  [[ $EXIT > 0 ]] && PS1="$PS1\[\e[1;31m\]]\[\e[m\]" || PS1="$PS1\[\e[1;32m\]]\[\e[m\]" # Left |

  PS1="$PS1\[\e[1;33m\][\[\e[m\]\[\e[1;33m\]\h\[\e[m\]\[\e[1;33m\]]\[\e[m\]" # [hostname]
  PS1="$PS1\n" #new line

  if [[ `parse_git_branch` != "" ]]; then
    [[ $EXIT > 0 ]] && PS1="$PS1\[\e[1;31m\]│\[\e[m\] " || PS1="$PS1\[\e[1;32m\]│\[\e[m\] " # color coded pipe |
    PS1="$PS1\[\e[1;35m\]\`parse_git_branch\`\[\e[m\]" # git working dir
    PS1="$PS1\n" #new line
  fi

  [[ $EXIT > 0 ]] && PS1="$PS1\[\e[1;31m\]└─⚡\[\e[m\] " || PS1="$PS1\[\e[1;32m\]└─*\[\e[m\] " # prompt line carriage
}
#Startup Welcomes
export PROMPT_COMMAND=__promptCommand

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
