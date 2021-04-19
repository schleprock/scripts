# test args
if [ ! ${#} -ge 3 ] || [ $# -gt 4 ]; then
    echo 1>&2 "Usage: ${0} LOCAL REMOTE MERGED BASE"
    echo 1>&2 "       (LOCAL, REMOTE, MERGED, BASE can be provided by \`git mergetool'.)"
    sleep 30
    exit 1
fi
 
echo "number args $#"
# args
_LOCAL=${1}
_REMOTE=${2}
_MERGED=${3}
if [ $# -eq 4 ] ; then
    _BASE=${4}
    _EDIFF=ediff-merge-files-with-ancestor
    _EVAL="${_EDIFF} \"${_LOCAL}\" \"${_REMOTE}\" \"${_BASE}\" nil \"${_MERGED}\""
else
    _EDIFF=ediff-merge-files
    _EVAL="${_EDIFF} \"${_LOCAL}\" \"${_REMOTE}\" nil \"${_MERGED}\""
fi
 
# run emacs
echo "running d:/emacs-24.3/bin/runemacs.exe --eval \"(${_EVAL})\""
"d:/emacs-24.3/bin/runemacs.exe" --eval "(${_EVAL})" 2>&1
# emacs  --eval "(${_EVAL})" 2>&1
sleep 30
