# ~/.bash_logout

echo ".bash_logout"
# reset background to all white
echo -e '\e]11;rgb:ff/ff/ff\a'
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
