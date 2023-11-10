#!/bin/bash

function task_1 {
    echo "======= Aufgabe 1: Größenverhältnisse von Zahlen überprüfen ======="
    read -p "Bitte gib die erste Zahl ein: " num1
    read -p "Bitte gib die zweite Zahl ein: " num2

    if [ ${#num1} -gt 15 ] || [ ${#num2} -gt 15 ]; then
        echo "Die maximale Zahlenlänge ist 15 Zeichen."
    else
        if [ "$num1" -gt "$num2" ]; then
            echo "$num1 ist größer als $num2."
        elif [ "$num1" -lt "$num2" ]; then
            echo "$num1 ist kleiner als $num2."
        else
            echo "$num1 und $num2 sind gleich."
        fi
    fi
    echo "==================================================================="
    explain_code task_1
}

function task_2 {
    echo "======= Aufgabe 2: IP-Adresse auslesen ======="
    ifconfig -a
    read -p "Möchtest du eine bestimmte Netzwerkschnittstelle angeben? (ja/nein): " answer

    if [ "$answer" == "ja" ]; then
        read -p "Bitte gib die Netzwerkschnittstelle ein (z.B. eth0): " interface
        ip addr show $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
    fi
    echo "==================================================================="
    explain_code task_2
}

function task_3 {
    echo "======= Aufgabe 3: Ratespiel ======="
    target=$((1 + RANDOM % 20))

    for attempt in {1..3}; do
        read -p "Versuch $attempt: Gib eine Zahl zwischen 1 und 20 ein: " guess

        if [ "$guess" -eq "$target" ]; then
            echo "Herzlichen Glückwunsch! Du hast die richtige Zahl erraten."
            exit 0
        elif [ "$guess" -lt "$target" ]; then
            echo "Die gesuchte Zahl ist größer."
        else
            echo "Die gesuchte Zahl ist kleiner."
        fi
    done

    echo "Leider keine richtige Zahl erraten. Die richtige Zahl war $target."
    echo "==================================================================="
    explain_code task_3
}

function task_4 {
    echo "======= Aufgabe 4: Quadrat zeichnen ======="
    read -p "Anzahl der Zeilen und Spalten: " size

    for ((i=1; i<=size; i++)); do
        for ((j=1; j<=size; j++)); do
            echo -n "X"
        done
        echo
    done
    echo "==================================================================="
    explain_code task_4
}

function task_5 {
    echo "======= Aufgabe 5: Primzahlen ausgeben ======="
    read -p "Grenze für Primzahlen eingeben: " limit

    for ((num=2; num<=limit; num++)); do
        is_prime=true

        for ((i=2; i<num; i++)); do
            if [ $((num % i)) -eq 0 ]; then
                is_prime=false
                break
            fi
        done

        if $is_prime; then
            echo -n "$num "
        fi
    done

    echo
    echo "==================================================================="
    explain_code task_5
}

function task_6 {
    echo "======= Aufgabe 6: Dateien umbenennen ======="
    read -p "Dateimuster eingeben (z.B. .pdf): " pattern

    for file in *$pattern; do
        echo "Umbenennen von '$file' in:"
        read -p "Neuer Dateiname (ohne Erweiterung): " new_name
        mv "$file" "$new_name$pattern"
    done
    echo "==================================================================="
    explain_code task_6
}

function task_7 {
    echo "======= Aufgabe 7: Hardwareinformationen ausgeben ======="
    echo "CPU:"
    echo "Hersteller: $(lscpu | grep 'Vendor ID' | awk '{print $3}')"
    echo "Architektur: $(lscpu | grep 'Architecture' | awk '{print $2}')"
    echo "Taktrate: $(lscpu | grep 'CPU MHz' | awk '{print $3}') MHz"
    echo "Cache: $(lscpu | grep 'L3 cache' | awk '{print $3, $4}')"

    echo -e "\nRAM:"
    echo "Arbeitsspeicher gesamt: $(free -h | grep 'Mem' | awk '{print $2}')"
    echo "Arbeitsspeicher in Benutzung: $(free -h | grep 'Mem' | awk '{print $3}')"

    echo -e "\nDateisysteme:"
    df -h --output=source,size,used | grep -vE '^Filesystem|tmpfs'
    echo "==================================================================="
    explain_code task_7
}

function task_8 {
    echo "======= Aufgabe 8: 6 aus 49 spielen ======="
    echo "Zufallszahlen: "
    for ((i=1; i<=6; i++)); do
        echo -n "$((1 + RANDOM % 49)) "
    done

    echo -e "\n\nBenutzerzahlen eingeben (getrennt durch Leerzeichen): "
    read -a user_numbers

    matches=0

    for user_num in "${user_numbers[@]}"; do
        for ((i=1; i<=6; i++)); do
            random_num=$((1 + RANDOM % 49))
            echo -n "$random_num "

            if [ "$user_num" -eq "$random_num" ]; then
                ((matches++))
            fi
        done
    done

    echo -e "\nTreffer: $matches"
    echo "==================================================================="
    explain_code task_8
}

function task_9 {
    echo "======= Aufgabe 9: Startskript für Dienstverwaltung ======="
    read -p "Dienstverwaltungsaktion auswählen (start/stop/restart/reload): " action

    case "$action" in
        start)
            echo "Dienst wird gestartet."
            # Befehl zum Starten des Dienstes
            ;;
        stop)
            echo "Dienst wird gestoppt."
            # Befehl zum Stoppen des Dienstes
            ;;
        restart)
            echo "Dienst wird neugestartet."
            # Befehl zum Neustarten des Dienstes
            ;;
        reload)
            echo "Konfiguration wird neu eingelesen."
            # Befehl zum erneuten Einlesen der Konfiguration
            ;;
        *)
            echo "Ungültige Aktion."
            ;;
    esac
    echo "==================================================================="
    explain_code task_9
}

function task_10 {
    echo "======= Aufgabe 10: Backupskript ======="
    read -p "Pfad zum Backup-Verzeichnis eingeben: " backup_dir
    read -p "Verzeichnis, das gesichert werden soll, eingeben: " source_dir

    date_stamp=$(date +"%Y%m%d")
    tar -czvf "$backup_dir/backup_$date_stamp.tar.gz" "$source_dir"
    echo "Backup erfolgreich erstellt: backup_$date_stamp.tar.gz"
    echo "==================================================================="
    explain_code task_10
}

function explain_code {
    read -p "Soll ich den Code erklären? (ja/nein): " explain

    if [ "$explain" == "ja" ]; then
        declare -f $1 | sed -n '/{/,$p' | sed -e '1d;$d'
    fi
}

while true; do
    clear
    echo "======= Aufgaben-Menü ======="
    echo "1. Größenverhältnisse von Zahlen überprüfen"
    echo "2. IP-Adresse auslesen"
    echo "3. Ratespiel"
    echo "4. Quadrat zeichnen"
    echo "5. Primzahlen ausgeben"
    echo "6. Dateien umbenennen"
    echo "7. Hardwareinformationen ausgeben"
    echo "8. 6 aus 49 spielen"
    echo "9. Startskript für Dienstverwaltung"
    echo "10. Backupskript"
    echo "0. Beenden"
    echo "============================="

    read -p "Welche Aufgabe möchtest du lösen? (0-10): " choice

    case $choice in
        1)
            task_1
            ;;
        2)
            task_2
            ;;
        3)
            task_3
            ;;
        4)
            task_4
            ;;
        5)
            task_5
            ;;
        6)
            task_6
            ;;
        7)
            task_7
            ;;
        8)
            task_8
            ;;
        9)
            task_9
            ;;
        10)
            task_10
            ;;
        0)
            echo "Auf Wiedersehen!"
            exit 0
            ;;
        *)
            echo "Ungültige Auswahl. Bitte versuche es erneut."
            ;;
    esac

    read -p "Drücke Enter, um zum Menü zurückzukehren."
done

