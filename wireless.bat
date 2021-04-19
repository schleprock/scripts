netsh interface ip set address "Wireless Network Connection" static 192.168.5.166 255.255.255.0 192.168.5.1 1
netsh interface ip set dns "Wireless Network Connection" static 192.168.2.3 primary
netsh interface ip add dns "Wireless Network Connection" 66.189.0.29 
netsh interface ip add dns "Wireless Network Connection" 66.189.0.30
netsh interface ip add dns "Wireless Network Connection" 66.189.0.5
