set "FOO=D:/cygwin/ansysdev/git/new3rdparty"

powershell -Command "[System.IO.Path]::GetCanonicalPath( '%FOO%' )"
