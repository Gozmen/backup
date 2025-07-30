#!/bin/bash
#Konfigurace
#TEST
BACKUP_FOLDER=("test_backup")
DESTINATION_BACKUP_FOLDER="$HOME/backups"
LOG="logs/backup.log"


mkdir -p "$DESTINATION_BACKUP_FOLDER"
mkdir -p "logs"

echo "[$(date)] Zahajuji zalohu...." | tee -a "$LOG"

for SLOZKA in "${BACKUP_FOLDER[@]}"; do
    if [ -d "$HOME/$SLOZKA" ]; then
        echo "[$(date)] Zalohuji $SLOZKA..." | tee -a "$LOG"
        NAZEV=$(basename "$SLOZKA")
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        ARCHIV=$DESTINATION_BACKUP_FOLDER/${NAZEV}_$TIMESTAMP.tar.gz
        if tar -czf "$ARCHIV" -C "$HOME" "$SLOZKA"; then
        echo "[$(date)] Hotovo: $ARCHIV" | tee -a "$LOG"
        else 
        echo "[$(date)] Chyba pri zaloze: $SLOZKA" | tee -a "$LOG"
        fi
    else 
     echo "[$(date)] Slozka $HOME/$SLOZKA neexistuje" | tee -a "$LOG"
    fi
done

echo "[$(date)] Zaloha dokoncena" | tee -a "$LOG"    