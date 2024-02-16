if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

umask 0002

export PERL5LIB=~/scripts/perl5lib:~/gitScripts/modules

# workaround stupid msys creating multiple tmp/temp env
# vars that only differ in case
unset tmp
unset temp

# test if TEMP and TMP exist, if not create and set
if [ -z "$TEMP" ] || [ -z "$TMP" ]; then
    if [ -n "$TEMP" ]; then
        # TEMP is set but not TMP
        export TMP=$TEMP
    elif [ -n "$TMP" ]; then
        # TMP is set but not TEMP
        export TEMP=$TMP
    else
        # neither is set, use generic TMP area
        if [ ! -d /tmp ]; then
            mkdir /tmp
        fi
        export TMP=/tmp
        export TEMP=$TMP
    fi
fi

myName=$(hostname)
os=$(uname -o)
workScriptsDir=""
if [ -d ~/TwinBuilder_Dev_ModelicaScripts ]; then
    workScriptsDir="~/TwinBuilder_Dev_ModelicaScripts:"
fi
if [ "$os" == "Msys" ]; then
    export PATH=~/scripts:~/gitScripts:${workScriptsDir}$PATH
    set -o igncr
    # msys overwrites TEMP/TMP which screws up debugging windows stuff,
    # just put it back
    export TEMP=$ORIGINAL_TEMP
    export TMP=$TEMP
    # have to search for a winders emacs to put on path
    emacsExe=`find /c/Program\ Files/Emacs/ -name "emacs.exe"`
    echo "emacsExe = $emacsExe"
    if [ -z "$emacsExe" ]; then
        echo "No winders emacs found"
    else
        echo "winders emacs found"
        emacsDir="$(dirname "$emacsExe")"
        echo "emacsDir = $emacsDir"
        export PATH=$PATH:$emacsDir
    fi

fi

if [ "$os" == "Cygwin" ]; then
    export PATH=/bin:~/scripts:~/gitScripts:$PATH
    export SHELLOPTS
    set -o igncr
    # this next one is for generating certificate on windows machine
    export RANDFILE=~/.rnd
    export TERM=xterm
	xhost +
fi

if [ "$os" == "GNU/Linux" ]; then
    export PATH=~/scripts:~/gitScripts:${workScriptsDir}$PATH
    export NUMBER_OF_PROCESSORS=`nproc`
    alias chrome="google-chrome"
    # start ssh-agent for gitkraken, only on linux
    #if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    #    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
    #fi
    #if [[ ! "$SSH_AUTH_SOCK" ]]; then
    #    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
    #fi
    export ANSYSEM_ROOT242=/ansysdev/AnsysEM/v242/Linux64
    export ANSYSEM_ROOT241=/ansysdev/AnsysEM/v241/Linux64
    export ANSYSEM_ROOT232=/ansysdev/AnsysEM/v232/Linux64
fi
export OLD_PATH=$PATH
export BUILD_SITE=1

if [[ $- =~ "i" ]]; then
    #we're interactive
    echo "interactive"
    echo "OS: ${os}"
else
    return
fi


source ~/scripts/aliasStuff
if [ -f ~/TwinBuilder_Dev_ModelicaScripts/moreAliasStuff ]; then
    echo "Loading more alias stuff"
    source ~/TwinBuilder_Dev_ModelicaScripts/moreAliasStuff
fi
if [ -f ~/TwinBuilder_Dev_ModelicaScripts/workBashrcStuff ]; then
    echo "Loading more work bashrc"
    source ~/TwinBuilder_Dev_ModelicaScripts/workBashrcStuff
fi

if [ -n "$SSH_CLIENT" ]; then
    CLIENTIP=`echo $SSH_CLIENT | awk '{print $1}'`
    echo "connected to $CLIENTIP"
    DISP=`hostname -i`
    DISP=${DISP}:10.0
    echo "Setting DISPLAY to $DISP"
    #export DISPLAY=$DISP
fi

export EDITOR=emacs
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

source ~/scripts/proml
proml

# this function is used to set ctrl-V as paste in terminal's
# requires the following line to be added to .inputrc
#      set bind-tty-special-chars off
paste () {
  CLIP=$(cat /dev/clipboard)
  COUNT=$(echo -n "$CLIP" | wc -c)
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${CLIP}${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(($READLINE_POINT + $COUNT))
}
bind -x '"\C-v": paste'
