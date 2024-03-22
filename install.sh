#!/bin/bash
sudo apt install -y python3-pip
pip3 install python-telegram-bot
python3 -m pip install --user telebot
clear
read -p 'Enter bot token: ' token
read -p 'Enter chat id: ' chat_id
read -p "Enter backup period in minutes: " min
x="pwd"
eval "$x"
path=$(eval "$x")

echo "
 [Unit]
 Description=My Telegram Bot $chat_id

 [Service]
 User=root
 WorkingDirectory=$path
 ExecStart=/usr/bin/python3 $path/backup$chat_id.py
 Restart=always

 [Install]
 WantedBy=multi-user.target" > /etc/systemd/system/mybot$chat_id.service
echo "
import os
import time
import telebot
# Set up the bot
bot = telebot.TeleBot(\"$token\")

# Set the chat ID to send the file to
chat_id = \"$chat_id\"

# Get the hostname and IP address of the current server
hostname = os.uname().nodename
ip_address = os.popen(\"curl -s https://api.ipify.org\").read().strip()

# Set the path to the database file
db_path = \"/etc/x-ui/x-ui.db\"

# Set the interval to send the file (in seconds)
interval = $min * 60

while True:
    # Compose the message with the server hostname, IP address, and database file
    message = f\"Server: {hostname} ({ip_address})\nDatabase file:\"
    with open(db_path, \"rb\") as file:
        bot.send_document(chat_id, file, caption=message)
    # Sleep for the specified interval
    time.sleep(interval)" > backup$chat_id.py
systemctl daemon-reload
systemctl start mybot$chat_id
systemctl enable mybot$chat_id
