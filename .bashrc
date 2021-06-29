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
if [ "$os" == "Msys" ]; then
    export PATH=~/scripts:~/gitScripts:/c/Program\ Files/Emacs/x86_64/bin/:$PATH
     set -o igncr
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
    export PATH=~/scripts:~/gitScripts:$PATH
    export NUMBER_OF_PROCESSORS=`nproc`
    alias chrome="google-chrome"
fi

export BUILD_SITE=1

if [[ $- =~ "i" ]]; then
    #we're interactive
    echo "interactive"
    echo "OS: ${os}"
else
    return
fi


source ~/scripts/aliasStuff

if [ -n "$SSH_CLIENT" ]; then
    CLIENTIP=`echo $SSH_CLIENT | awk '{print $1}'`
    echo "connected to $CLIENTIP"
    export DISPLAY=${CLIENTIP}:0.0
fi

export EDITOR=emacs

source ~/scripts/proml
proml


