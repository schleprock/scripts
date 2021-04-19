"C:\Program Files (x86)\ImgBurn\ImgBurn.exe" /mode read /src e: /dest "d:\cd images\audiocd" /verify no /start /closesuccess /overwrite yes /eject yes /waitformedia
sleep 2
"C:\Program Files (x86)\ImgBurn\ImgBurn.exe" /mode write /src "d:\cd images\audiocd.cue" /dest f: /verify = no /closesuccess /start /waitformedia /eject yes
