#
# ~/.bashrc
#

[ -z "$PS1" ] && return   # If not running interactively, don't do anything

# bash prompt styles
#PS1='[\[\e[37m\]\u\[\e[31m\]@\[\e[37m\]\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]] \$ '
#PS1="\[\e[36;1m\][\[\e[34;1m\]\w\[\e[36;1m\]]: \[\e[0m\]"
#PS1="\[\e[0m\][\[\e[0m\]\w\[\e[0m\]]: \[\e[0m\]"
#PS1="\[\e[0m\]\u \e[31m\]\w\[\e[0m\] "
#PS1="┌─[\[\e[36;1m\]\u @ \[\e[32;1m\]\H\[\033[1;37m\]] \n\[\033[1;37m\]└─[\[\033[0;36m\]\w\[\033[1;37m\]]> \[\e[0m\]"
PS1="\[\033[36m\]\u\[\033[37m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$ "

eval `dircolors -b ~/.dircolors`

shopt -s cdspell
shopt -s extglob
shopt -s cmdhist
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -u promptvars
set -o noclobber
set -o emacs
#kill flow control
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

# command history settings
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/mozilla/bin:/opt/java/jre/bin:/home/zaynaly/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LOCALE=en_US.UTF-8
export BROWSER=firefox3
#export MANPAGER=vimpager
#export MAIL=/home/gig/.mail/default
#export PACKAGER="Gigamo <gigamo@gmail.com>"
export CVS_RSH="ssh"
export OOO_FORCE_DESKTOP="gnome"
export EDITOR=vim
export VISUAL=vim
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000
export HISTSIZE=10000

# bash completion
complete -cf sudo         # sudo tab-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# general aliases
alias ca="cd /opt/OpenCA-0.9.2.5/"

# Host specific aliases
case $HOSTNAME in
	giGnote)
		alias outside="weatherget -s BEXX0008 -m"
	;;
	*)
		alias outside="weatherget -s BEXX0008 -m"
	;;
esac

alias mv="mv -v --backup=existing"
alias mmv="noglob zmv -W"
alias rm="rm -v"
alias cp="cp -v"
alias mplayer="mplayer -idx"
alias wget="wget --timeout 10"
alias grep="grep --color=auto"
#alias irb="irb --simple-prompt"

#function call
alias ex=extract_archive

# todos!
#alias t="/home/zaynaly/bin/todo.sh"
#alias tl="t ls"
#alias ta="t add"

# basics
alias c="clear"
alias l="ls -l"
alias ll='ls -ahl --color | more; echo "\e[1;32m --[\e[1;34m Dirs:\e[1;36m `ls -al | egrep \"^drw\" | wc -l` \e[1;32m|\e[1;35m Files: \e[1;31m`ls -al | egrep -v \"^drw\" | grep -v total | wc -l` \e[1;32m]--"'
#alias e="emacs -nw"
alias v="vim"
alias wh="when ci --past=0 --future=3"
alias cdc="cd; clear"

# more interesting aliases :D
#alias boggle='echo "No no no, Mr. Brian Braun-Duin"'
#alias conngig='sudo iwlist wlan0 scan && sudo netcfg2 wireless-gigamo'
#alias connmarina='sudo iwlist wlan0 scan && sudo netcfg2 wireless-marina'

alias wcat='wget -q -O -'
#alias pacup='sudo pacman -Syu'
alias start='dbus-launch startx'
alias install='sudo apt-get install'
alias search='apt-cache search'
#alias remove='sudo pacman -Rscn'
#alias yaoup='sudo yaourt -Syu --aur'
#alias yaous='sudo yaourt -Ss'
#alias yinstall='sudo yaourt -S'
#alias yremove='sudo yaourt -Rsn'
alias zetaf="sudo shutdown -h now"
alias reboot="sudo reboot"
alias svim="sudo vim"
#alias netcfg="netcfg2"
#alias battery="/home/gig/bin/battery.pl"
alias ls="ls -hF --color=auto"
#unalias -a               # uncomment to unalias everything 

# bash functions

# list contents of directory on every "cd"

function pastie {
  url=$(curl http://pastie.caboo.se/pastes/create \
    -H "Expect:" \
    -F "paste[parser]=plain_text" \
    -F "paste[body]=<-" \
    -F "paste[authorization]=burger" \
    -s -L -o /dev/null -w "%{url_effective}")
  echo -n "$url" | xclip
  echo "$url"
}

function aurget {
  cd ~/abs
  wget "http://aur.archlinux.org/packages/$1/$1.tar.gz" -O - | tar xzf -
  cd $1
}

# viewing man pages
function man
{
  /usr/bin/man $* | col -bp | iconv -c | view -c 'set ft=man nomod nolist' -
}

function todo {
  if [ $#argv = 0 ]; then
    less ~/.todo
  else
    formatted=$(print -P "%D{%F}, $1: $2")
    print $formatted >>~/.todo
    print $formatted
  fi
}

#echo "start of Problem Area"
# hg rcs functions
#function hgs() { hg status $* }
#function hgl() { hg log $* }
#function hgc() { hg commit -m "$*" }
#function hgp() { hg push $* }
#function hga() { hg add $* }

# git functions
#function ga() { git add $* }
#function gl() { git log $* }
#function gs() { git status $* }
#function gp() { git push $* }
#function gc() { git commit -m "$*" }

#echo "End of Problem Area"
# SEARCH: summarized google, ggogle, mggogle, agoogle and fm
function search()
{
	case "$1" in
		-g) ${BROWSER:-lynx} http://www.google.com/search\?q=$2
		;;
		-u) ${BROWSER:-lynx} http://groups.google.com/groups\?q=$2
		;;
		-m) ${BROWSER:-lynx} http://groups.google.com/groups\?selm=$2
		;;
		-a) ${BROWSER:-lynx} http://groups.google.com/groups\?as_uauthors=$2
		;;
		-c) ${BROWSER:-lynx} http://search.cpan.org/search\?query=$2\&mode=module
		;;
		-f) ${BROWSER:-lynx} http://freshmeat.net/search/\?q=$2\&section=projects
		;;
		-F) ${BROWSER:-lynx} http://www.filewatcher.com/\?q=$2
		;;
		-G) ${BROWSER:-lynx} http://www.rommel.stw.uni-erlangen.de/~fejf/cgi-bin/pfs-web.pl\?filter-search_file=$2
		;;
		-s) ${BROWSER:-lynx} http://sourceforge.net/search/\?type=soft\&q=$2
		;;
		-w) ${BROWSER:-lynx} http://de.wikipedia.org/wiki/$2
		;;
		-W) ${BROWSER:-lynx} http://en.wikipedia.org/wiki/$2
		;;
		-d) lynx -source "http://dict.leo.org?$2" | grep -i "TABLE.*/TABLE" | sed "s/^.*\(<TABLE.*TABLE>\).*$/<HTML><BODY>\1<\/BODY><\/HTML>/" | lynx -stdin -dump -width=$COLUMNS -nolist;
		;;
		*) 
		  echo "Usage: $0 {-g | -u | -m | -a | -f | -c | -F | -s | -w | -W | -d}"
		  echo "	-g:  Searching for keyword in google.com"
		  echo "	-u:  Searching for keyword in groups.google.com"
		  echo "	-m:  Searching for message-id in groups.google.com"
		  echo "	-a:  Searching for Authors in groups.google.com"
		  echo "	-c:  Searching for Modules on cpan.org."
		  echo "	-f:  Searching for projects on Freshmeat."
		  echo "	-F:  Searching for packages on FileWatcher."
		  echo "	-G:  Gentoo file search."
		  echo "	-s:  Searching for software on Sourceforge."
		  echo "	-w:  Searching for keyword at wikipedia (german)."
		  echo "	-W:  Searching for keyword at wikipedia (english)."
		  echo "	-d:  Query dict.leo.org ;)"
	esac
}

extract_archive () {
    local old_dirs current_dirs lower
    lower=${(L)1}
    old_dirs=( *(N/) )
    if [[ $lower == *.tar.gz || $lower == *.tgz ]]; then
        tar xvzf $1
    elif [[ $lower == *.gz ]]; then
        gunzip $1
    elif [[ $lower == *.tar.bz2 || $lower == *.tbz ]]; then
        tar xvjf $1
    elif [[ $lower == *.bz2 ]]; then
        bunzip2 $1
    elif [[ $lower == *.zip ]]; then
        unzip $1
    elif [[ $lower == *.rar ]]; then
        unrar e $1
    elif [[ $lower == *.tar ]]; then
        tar xvf $1
    elif [[ $lower == *.lha ]]; then
        lha e $1
    else
        print "Unknown archive type: $1"
        return 1
    fi
    # Change in to the newly created directory, and
    # list the directory contents, if there is one.
    current_dirs=( *(N/) )
    for i in {1..${#current_dirs}}; do
        if [[ $current_dirs[$i] != $old_dirs[$i] ]]; then
            cd $current_dirs[$i]
            break
        fi
    done
}

roll () {
    FILE=$1
    case $FILE in
        *.tar.bz2) shift && tar cjf $FILE $* ;;
        *.tar.gz) shift && tar czf $FILE $* ;;
        *.tgz) shift && tar czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
    esac
}

function mkcd() { mkdir "$1" && cd "$1"; }
function calc() { echo "$*" | bc; }
function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }
function mktar() 
{ 
  if [ ! -z "$1" ]; then
    tar czf "${1%%/}.tar.gz" "${1%%/}/"; 
  else
    echo "Please specify a file or directory"
    exit 1
  fi
}
function mkmine() { sudo chown -R ${USER} ${1:-.}; }

# search the vim reference manual for keyword
:h() {  vim --cmd ":silent help $@" --cmd "only"; }

# sanitize - set file/directory owner and permissions to normal values (644/755)
# Usage: sanitize <file>
sanitize() {
    chmod -R u=rwX,go=rX "$@"
    chown -R ${USER}.users "$@"
}

# GNU Screen Login greeting
if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
  detached_screens=`screen -list | grep Detached`
  if [ ! -z "$detached_screens" ]; then
    echo "+---------------------------------------+"
    echo "| Detached screens are available:       |"
    echo "$detached_screens"
    echo "+---------------------------------------+"
  else
    echo "[ screen is activated ]"
  fi
  export SHOWED_SCREEN_MESSAGE="true"
fi

# linux console colours - ala Phrakture
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi

#if tty -s; then
#  motd
#fi
