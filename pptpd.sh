#!/bin/sh

mkdir -p /tmp/chaps
mkdir -p /etc/ppp

# Create a file for every username
i=0
for u in $(echo $USERNAMES | sed "s/, */ /g"); do
    echo -n "$u * " > "/tmp/chaps/$i"
    i=$((i+1))
done

# Loop through passwords and append to username file
i=0
for p in $(echo $PASSWORDS | sed "s/, */ /g"); do
    echo "$p * " >> "/tmp/chaps/$i"
    i=$((i+1))
done

# Concatenate /tmp/chaps/* into chap-secrets
cat /tmp/chaps/* > /etc/ppp/chap-secrets

# Remove temporary files
rm /tmp/chaps/*
rmdir /tmp/chaps

# Prepare iptables and ppp
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# pptpd logs to SYSLOG, so let pptpd start in background
pptpd

# ... and run SYSLOG in foreground, dumping to stdout
syslogd -n -O /dev/stdout
