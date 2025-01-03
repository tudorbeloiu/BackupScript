#!/bin/bash

BACKUP_DIR="$HOME/backups"
LOG_FILE="$BACKUP_DIR/backup.log"
RETENTION_DAYS=33

mkdir -p "$BACKUP_DIR"


echo "La ce interval vrei sa se faca backup?"
echo "1. La fiecare minut(nerecomandat)"
echo "2. La fiecare ora"
echo "3. La fiecare zi"
echo "4. O data pe saptamana"
echo "5. O data pe luna"
read -p "Alege o optiune (1/2/3/4/5): " OPTION

#configuram crontabul

case $OPTION in
    1)
       CRON_TIME="* * * * *"
       ;;
    2)
       CRON_TIME="0 * * * *"
       ;;
    3)
       CRON_TIME="0 0 * * *"
       ;;
    4)
       echo
       echo "Alege o zi a saptamanii: "
       echo "1. Luni"
       echo "2. Marti"
       echo "3. Miercuri"
       echo "4. Joi"
       echo "5. Vineri"
       echo "6. Sambata"
       echo "7. Duminica"
       read -p "Alegerea ta (1/2/3/4/5/6/7): " zi

       CRON_TIME="30 10 * * $zi"
       ;;

    5)
       read -p "Alege o zi din luna (1-30): " zi_luna
       CRON_TIME="30 10 $zi_luna * *"
       ;;

    *)
       echo "Optiune invalida!"
       exit 1
       ;;
esac

read -p "Introdu calea completa unde este salvat script-ul: " SCRIPT_PATH
(crontab -l 2>/dev/null; echo "$CRON_TIME bash $SCRIPT_PATH >> /dev/null 2>&1") | crontab -

echo "Jobul cron a fost adaugat cu succes pentru a rula scriptul de backup la intervalul specificat."

read -p "Introdu directoarele pentru backup, separate prin spatiu: " -a DIRECTORIES


#cream backup-ul

TIMESTAMP=$(date +%Y-%m-%d_%H-%M)

for DIR in "${DIRECTORIES[@]}"; do
   if [[ -d "$DIR" ]]; then
      BACKUP_SUBDIR="$BACKUP_DIR/$(basename $DIR)_$TIMESTAMP"
      mkdir -p "$BACKUP_SUBDIR"
      rsync -av --progress "$DIR/" "$BACKUP_SUBDIR"
      echo "$(date) Backup completat pentru $DIR" >> "$LOG_FILE"
   else
      echo "$(date) Directorul $DIR nu exista!" >> "$LOG_FILE"
   fi
done

find "$BACKUP_DIR" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \;
echo "$(date) Backup-uri mai vechi de $RETENTION_DAYS zile au fost sterse." >> "$LOG_FILE"


#restaurare  (optional)
read -p  "Doresti sa restaurezi un backup? (da/nu): " restore_choice


if [[ "$restore_choice" == "da" ]]; then

select RESTORE_DIR in "$BACKUP_DIR"/*; do
    read -p "Introdu locatia unde sa fie restaurat: " RESTORE_LOCATION
    rsync -av --progress "$RESTORE_DIR/" "$RESTORE_LOCATION"
    echo "$(date) Restaurare completa pentru $RESTORE_DIR la $RESTORE_LOCATION" >> "$LOG_FILE"
    break
done

else
   echo "Nu s-a realizat nicio restaurare."
fi

