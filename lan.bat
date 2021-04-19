netsh interface ip set address "Network Bridge" static 192.168.5.164 255.255.255.0 192.168.5.1 1
netsh interface ip set dns "Network Bridge" static 192.168.2.3 primary
netsh interface ip add dns "Network Bridge" 66.189.0.29 
netsh interface ip add dns "Network Bridge" 66.189.0.30
netsh interface ip add dns "Network Bridge" 66.189.0.5
