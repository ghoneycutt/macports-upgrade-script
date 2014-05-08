#!/bin/bash

rm -f /tmp/outdated_ports.lst
port -d sync
port list outdated
port list outdated > /tmp/outdated_ports.lst
port -c -d selfupdate
port -c -v selfupdate
port -c -d upgrade outdated
port -c -R -d upgrade installed
port list inactive
port -v uninstall inactive
find /opt/local/var/macports/software/ -type f -name *.tbz2 -exec rm -f {} \;
port clean installed
cat /tmp/outdated_ports.lst
for i in $(awk '{print $1}' /tmp/outdated_ports.lst); do echo -e "\n"; port info $i; done
rm -f /tmp/outdated_ports.lst
