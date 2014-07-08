# =============================================================== #
#                                                                 #
# PERSONAL $HOME/.bashrc FILE                                     #
# By Paul Dittaro [pdittaro@gmail.com]                            #
#                                                                 #
#                                                                 #
# Here is the place to define your aliases, functions and         #
# other interactive features like your prompt.                    #
#                                                                 #
#                                                                 #
# =============================================================== #


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


#-------------------------------------------------------------
# Aliases / Functions
#-------------------------------------------------------------

alias la='ls -la'

alias cdtc='cd $TOMCAT_HOME'
alias th='cd ~/.local/opt/apache-tomcat-6.0.37'
alias cdwl='cd $MW_HOME'

alias xml='xmlstarlet'

function title {
   echo -en "\033]2;$@\007"
}


#-------------------------------------------------------------
# Colors
#-------------------------------------------------------------

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;36m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[1;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background


#-------------------------------------------------------------
# PS1
#-------------------------------------------------------------


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Black}${On_Blue}        # Connected on remote machine, via ssh (good).
else
    CNX=${Cyan}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
else
    SU=${Blue}         # User is normal (well ... most of us are).
fi

unset PS1

case ${TERM} in
  *term | rxvt | linux | xterm-256color | screen-256color)
        # User@Host (with connection type info):
        PS1="\[${Blue}\](\[${SU}\]\u\[${NC}\]@\[${CNX}\]\h \[${NC}\]\W\[${Blue}\])\[${NC}\]"
        # Git status
	if [[ __git_ps1 ]]; then
		PS1=${PS1}"\[${White}\]\$(__git_ps1) \[${NC}\]"
	fi
	# Console prompt
	if [[ ${USER} == "root" ]]; then
		PS1=${PS1}"\[${SU}\]#\[${NC}\] "
	else
		PS1=${PS1}"\[${SU}\]$\[${NC}\] "
	fi

        ;;
    *)
        PS1="[\A \u@\h \W] $ " # --> PS1="(\A \u@\h \w) > "
                               # --> Shows full pathname of current dir.
        ;;
esac


