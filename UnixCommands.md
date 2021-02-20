# Add routes to network table

sudo ip route add 212.35.60.35 via 10.0.0.1 dev wlp4s0
sudo ip route add 212.35.60.35 via 192.168.1.1 dev enp3s0

💋 >route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         www.routerlogin 0.0.0.0         UG    100    0        0 enp3s0

10.0.0.0        0.0.0.0         255.0.0.0       U     50     0        0 vpn0
10.80.0.0       0.0.0.0         255.255.240.0   U     50     0        0 vpn0
10.192.0.0      0.0.0.0         255.255.0.0     U     50     0        0 vpn0
link-local      0.0.0.0         255.255.0.0     U     1000   0        0 vpn0
192.168.0.0     0.0.0.0         255.255.0.0     U     50     0        0 vpn0

212.35.60.0     0.0.0.0         255.255.255.0   U     50     0        0 vpn0
www.routerlogin 0.0.0.0         255.255.255.255 UH    100    0        0 enp3s0
vpn03.sunrise.n www.routerlogin 255.255.255.255 UGH   100    0        0 enp3s0
das-beste-netz. www.routerlogin 255.255.255.255 UGH   0      0        0 enp3s0
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp3s0


#Speed Test
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -


#Disable CORS Client Side - https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
Chrome
	Unix -> google-chrome --disable-web-security --user-data-dir=/home/rathi/non-default-chrome -ignore-certificate-errors
			chromium --disable-web-security --user-data-dir=/home/rathi/non-default-chrome -ignore-certificate-errors
	Windows -> "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-web-security --disable-gpu --user-data-dir=~/chromeTemp
	

#Independent instance for workspaces ubuntu
-> gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true

