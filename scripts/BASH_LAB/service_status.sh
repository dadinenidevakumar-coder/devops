#!/usr/bin/env bash
service="${1:- }"

if [[ -z "$service" ]]; then
read -r -p "Enter service name (default : nginx): " service
service="${service:-nginx}"
fi

if systemctl is-active --quiet "$service" ; then
echo "OK:service is ACTIVE"
exit 0
 else
echo "WARN:service is NOT  active"
exit 1
fi
