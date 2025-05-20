#!/bin/sh

# !!! chmod +x /domain.sh !!!

set -e

usage() {
    echo "Использование: $0 [--add | --remove] <домен> [IP]"
    echo "  --add     Добавить домен в /etc/hosts (по умолчанию IP = 127.0.0.1)"
    echo "  --remove  Удалить домен из /etc/hosts"
    exit 1
}

if [ "$#" -lt 2 ]; then
    usage
fi

ACTION="$1"
DOMAIN="$2"
IP="${3:-127.0.0.1}"  # По умолчанию IP — 127.0.0.1

HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.bak"

case "$ACTION" in
    --add)
        if grep -q "[[:space:]]$DOMAIN" "$HOSTS_FILE"; then
            echo "⚠️  Домен $DOMAIN уже существует в $HOSTS_FILE"
        else
            echo "📌 Добавляем $DOMAIN -> $IP в $HOSTS_FILE"
            sudo cp "$HOSTS_FILE" "$BACKUP_FILE"
            echo "$IP    $DOMAIN" | sudo tee -a "$HOSTS_FILE" > /dev/null
            echo "✅ Готово. Резервная копия: $BACKUP_FILE"
        fi
        ;;
    --remove)
        if grep -q "[[:space:]]$DOMAIN" "$HOSTS_FILE"; then
            echo "🧹 Удаляем $DOMAIN из $HOSTS_FILE"
            sudo cp "$HOSTS_FILE" "$BACKUP_FILE"
            sudo sed -i "/[[:space:]]$DOMAIN/d" "$HOSTS_FILE"
            echo "✅ Готово. Резервная копия: $BACKUP_FILE"
        else
            echo "ℹ️  Домен $DOMAIN не найден в $HOSTS_FILE"
        fi
        ;;
    *)
        usage
        ;;
esac