#!/usr/bin/env bash


folder="${1:-}"

      if [[ -z "$folder" ]]; then
   read -r -p "Enter log folder (default:/var/log): " folder
         folder="${folder:-/var/log}"
        fi
days="${2:-}"

      if [[ -z "$days" ]]; then
    read -r -p "Enter days (default:7):" days
         days="${days:-7}"
        fi

mkdir -p logs
logfile="logs/cleanup_$(date +%F)"

log() {
ts="$(date '+%F %T')"
printf "%s [%s] %s\n" "$ts" "$1" "$2" | tee -a "$logfile"
        }

if [[ ! -d "$folder" ]]; then
     log "ERROR" "folder not found: $folder"
      exit 2 
    fi

log "INFO" "Deleting *.log older than $days days in: $folder"
log "INFO" "Preview files:"

find "$folder" -type f -name "*.log" -mtime +"$days" -print | tee -a "$logfile"

       echo
   read -r -p "Type YES to delete: " ans
  if [[ "$ans" == "YES" ]]; then
 find "$folder" -type f -name "*.log" -mtime +"$days" -delete
    log "OK" "Deleted old logs"
   exit 0
 else
    log "INFO" "Canceled"
  exit 0
  fi





