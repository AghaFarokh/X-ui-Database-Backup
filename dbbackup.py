import os
import time
import telebot

# Set up the bot
bot = telebot.TeleBot("YOUR_API_TOKEN")

# Set the chat ID to send the file to
chat_id = "YOUR_CHAT_ID"

# Get the hostname and IP address of the current server
hostname = os.uname().nodename
ip_address = os.popen("curl -s https://api.ipify.org").read().strip()

# Set the path to the database file
db_path = "/etc/x-ui/x-ui.db"

# Set the interval to send the file (in seconds)
interval = 6 * 60 * 60

while True:
    # Sleep for the specified interval
    time.sleep(interval)

    # Compose the message with the server hostname, IP address, and database file
    message = f"Server: {hostname} ({ip_address})\nDatabase file:"
    with open(db_path, "rb") as file:
        bot.send_document(chat_id, file, caption=message)

