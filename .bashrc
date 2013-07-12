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


function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}


#-------------------------------------------------------------
# Colors
#-------------------------------------------------------------

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
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
# OnStart()
#-------------------------------------------------------------

if [ -x /usr/bin/fortune ]; then
	/usr/bin/fortune
fi



#-------------------------------------------------------------
# PS1
#-------------------------------------------------------------


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Black}${On_Green}        # Connected on remote machine, via ssh (good).
else
    CNX=${NC}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
else
    SU=${NC}         # User is normal (well ... most of us are).
fi

unset PS1

case ${TERM} in
  *term | rxvt | linux | xterm-256color | screen-256color)
	# Time
	PS1="\[${Purple}\]\T\[${NC}\]"
        # User@Host (with connection type info):
        PS1=${PS1}"[\[${SU}\]\u\[${NC}\]@\[${CNX}\]\h\[${NC}\]:\[${Yellow}\]\w\[${NC}\]"

	# Console prompt
	if [[ ${USER} == "root" ]]; then
		PS1=${PS1}"]\[${SU}\]#\[${NC}\] "
	else
		PS1=${PS1}"]\[${SU}\]$\[${NC}\] "
	fi

        # Set title of current xterm:
        PS1=${PS1}"\[\e]0;[\u@\h] \w\a\]"
        ;;
    *)
        PS1="[\A \u@\h \W] $ " # --> PS1="(\A \u@\h \w) > "
                               # --> Shows full pathname of current dir.
        ;;
esac

