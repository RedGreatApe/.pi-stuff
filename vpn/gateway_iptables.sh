# from https://zone13.io/post/raspberry-pi-vpn-gateway-for-nordvpn/
# flush all rules, start from 0
sudo iptables -F

# SSH allowed
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
# -m comment --comment "allow trafic from tunnel back to internal. state limits to initiated from internal"
sudo iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
# -m comment --comment "allowing any from eth0 to tun0"
sudo iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT

# -m comment --comment "vpn"
sudo iptables -A OUTPUT -o tun0 -j ACCEPT
# -m comment --comment "icmp"
sudo iptables -A OUTPUT -o eth0 -p icmp -j ACCEPT
# -m comment --comment "lan"
sudo iptables -A OUTPUT -d 192.168.0.0/24 -o eth0 -j ACCEPT
# -m comment --comment "allow vpn traffic"
sudo iptables -A OUTPUT -o eth0 -p udp -m udp --dport 1194 -j ACCEPT
# -m comment --comment "ntp"
sudo iptables -A OUTPUT -o eth0 -p udp -m udp --dport 123 -j ACCEPT
# -m comment --comment "nordvpn IP"
sudo iptables -A OUTPUT -p tcp -d [VPN SERVER IP] --dport 443 -j ACCEPT
# -m comment --comment "nordvpn IP"
sudo iptables -A OUTPUT -p tcp -d [VPN SERVER IP] --dport 443 -j ACCEPT
# sudo iptables -A OUTPUT -o eth0 -j DROP

# sudo iptables-save | sudo tee /etc/iptables/rules.v4


# from https://www.instructables.com/Raspberry-Pi-VPN-Gateway-NordVPN/

# -m comment --comment "enable nat"
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
# -m comment --comment "allow pi's own loopback traffic"
sudo iptables -A INPUT -i lo -j ACCEPT
# -m comment --comment "allow locals to ping pi"
sudo iptables -A INPUT -i eth0 -p icmp -j ACCEPT
# -m comment --comment "allow ssh internal"
sudo iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
# -m comment --comment "alllow traffic s tarted by pi to return"
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# drop everything else
# sudo iptables -P FORWARD DROP
sudo iptables -P INPUT DROP

# from a comment
# -m comment --comment "allow wlan internet if nordvpn is disconnected"
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

sudo netfilter-persistent save

sudo iptables-save | sudo tee /etc/iptables/rules.v4
