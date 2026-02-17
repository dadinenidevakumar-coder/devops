#!/usr/bin/env bash

service="${1:-}"
if [[ -z "$service" ]]; then
  read -r -p "Enter service name (default: ssh): " service
  service="${service:-ssh}"
fi

mkdir -p logs
logfile="logs/service_status_$(date +%F).log"

log() {
  ts="$(date '+%F %T')"
  printf "%s [%s] %s\n" "$ts" "$1" "$2" | tee -a "$logfile"
}

if ! command -v systemctl >/dev/null 2>&1; then
  log "ERROR" "systemctl not found"
  exit 2
fi

if systemctl is-active --quiet "$service"; then
  log "INFO" "Service '$service' is ACTIVE"
  exit 0
else
  log "WARN" "Service '$service' is NOT active"
  exit 1
fi
