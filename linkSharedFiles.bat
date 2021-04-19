set target="c:\Program Files\AnsysEM\Shared Files"
set linkName="Shared Files"
set myCmd="mklink /j %linkName% %target%"
cmd /C %myCmd%
