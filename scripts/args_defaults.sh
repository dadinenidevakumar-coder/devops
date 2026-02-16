#!/usr/bin/env bash
service="${1:-}"
if [[ -z "$service" ]]; then
read -r -p "Enter service name (default: nginx): " service
service="${service:-nginx}"
fi
echo "service:$service"

