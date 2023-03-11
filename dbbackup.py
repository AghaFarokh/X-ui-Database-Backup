import os
import socket
import time
import telebot

TOKEN = '<your_bot_token>'
CHAT_ID = '<your_chat_id>'

bot = telebot.TeleBot(TOKEN)

while True:
    # Get server hostname and IP address
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    
    # Construct the message
    message = f'Database file from {hostname} ({ip_address})\n'
    
    # Read the database file
    with open('/etc/x-ui/x-ui.db', 'rb') as file:
        contents = file.read()
    
    # Send the message and file
    bot.send_document(CHAT_ID, contents, caption=message)
    
    # Wait for 6 hours
    time.sleep(6 * 60 * 60)
