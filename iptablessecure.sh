#!/bin/bash

# 1. Flush all current rules from iptables
iptables -F
 
# 2. Do -NOT- remove the following line, 22 is to SSH in
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 3. Incoming http traffic
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8000 -j ACCEPT
#iptables -A INPUT -p tcp --dport 28017 -j ACCEPT
 
# 4. Allow email (SMTP and IMAP)
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -p tcp --dport 993 -j ACCEPT
#iptables -A INPUT -p tcp --dport 995 -j ACCEPT

# 5. Set access for localhost
iptables -A INPUT -i lo -j ACCEPT
 
# 6. Accept packets belonging to established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
# 7. Set default policies for INPUT, FORWARD and OUTPUT chains 
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT


# 8. Prevent DoS attack
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

# 9. Log dropped packets
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
iptables -A LOGGING -j DROP

