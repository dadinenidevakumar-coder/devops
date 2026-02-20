#!/usr/bin/env bash

limit="${1:-}"

    if [[ -z "$limit" ]]; then
         read -r -p "Enter limit percent (Default:80):" limit
            limit="${limit:-80}"
         fi
mkdir -p logs
    logfile="logs/disk_alert_$(date +%F).log"

log() {
         ts="$(date '+%F %T')"
          printf "%s [%s] %s\n" "$ts" "$!" "$2" | tee -a "$logfile"
        }

if ! command -v df >/dev/null 2>&1; then
  log "ERROR" "df command not found"
       exit 2
       fi


used="$(df -P / | tail -n 1 | tr -s ' ' | cut -d' ' -f5 | tr -d '%')"
            log "INFO" "Disk used on / = ${used}% (limit=${limit}%)"

if [[ "$used" -ge "$limit" ]]; then
      log "WARN" "Disk is HIGH"
        exit 1
    else
log "OK" "Disk is normal"
   exit 0
   fi
