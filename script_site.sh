#!/bin/bash

# Масив з URL вебсайтів для перевірки
websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
)

# Ім'я файлу логів
log_file="website_status.log"

# Очищення файлу логів перед записом нових результатів
> "$log_file"

echo "Перевірка доступності вебсайтів..."

# Цикл для перевірки кожного сайту
for site in "${websites[@]}"
do
    # Виконання HTTP GET запиту за допомогою curl і отримання статус коду
    http_code=$(curl -sL -w "%{http_code}" "$site" -o /dev/null)

    # Перевірка статус-коду
    if [ "$http_code" -eq 200 ]; then
        status="[${site}](${site}) is UP"
    else
        status="[${site}](${site}) is DOWN"
    fi

    # Вивід статусу в консоль
    echo "$status"

    # Запис статусу в файл логів
    echo "$status" >> "$log_file"
done

echo "Результати перевірки записано у файл логів: $log_file"
