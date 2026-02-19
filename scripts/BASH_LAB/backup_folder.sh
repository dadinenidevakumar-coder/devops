#!/usr/bin/env bash
     folder="${1:-}"

        if [[ -z "$folder" ]]; then
          read -r -p "Enter folder to backup (default:/etc): " folder
             folder="${folder:-/etc}"
                 fi

        dest="${2:-}"

       if [[ -z "$dest" ]]; then
          dest="/tmp/backups"
            fi
         mkdir -p logs
        logfile="logs/backup_$(date +%F).log"

   log() {
       ts="$(date '+%F %T')"
  printf "%s [%s] %s\n" "$ts" "$1" "$2" | tee -a "$logfile"
                }
if [[ ! -d "$folder" ]]; then
   log "ERROR" "folder not found: $folder"
     exit 2
             fi

if ! command -v tar >/dev/null 2>&1; then
     log "ERROR" "tar not found"
       exit 2
             fi
mkdir -p "$dest"
name="$(basename "$folder")"
file="$dest/${name}_$(date +%F_%H-%M-%S).tar.gz"

if tar -czf "$file" "$folder"; then
  log "OK" "Backup created: $file"
     exit 0
  else
log "WARN" "Backup failed (Permission Denied). Try: sudo ./backup_folder.sh $folder $dest"
        exit 1
     fi
