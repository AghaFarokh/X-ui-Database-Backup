# X-ui-Database-Backup

A Telegram bot to send x-ui database located in /etc/xui/x-ui.db to your chat id in telegram every 6 hours

Replace your bot token and your chat id in the file

    TOKEN = '<your_bot_token>'
    CHAT_ID = '<your_chat_id>'

How to run

    sudo apt install python3-pip
    pip3 install python-telegram-bot
    python3 -m pip install --user telebot
    
    nohup python3 dbbackup.py > output.log &

---------------------

To run this script in the background, you can use a process manager like systemd or supervisor. Here's how to use systemd:

Create a file called mybot.service in the /etc/systemd/system directory with the following contents:


     [Unit]
     Description=My Telegram Bot

     [Service]
     User=root
     WorkingDirectory=/path/to/my/bot/
     ExecStart=/usr/bin/python /path/to/my/bot/mybot.py
     Restart=always

     [Install]
     WantedBy=multi-user.target

Replace /path/to/my/bot/ and /path/to/my/bot/mybot.py with the actual path to your bot script.

Run the following commands to start and enable the service:


     systemctl daemon-reload
     systemctl start mybot
     systemctl enable mybot

Now the bot will run in the background and send the database file to your Telegram chat every 6 hours. You can check the logs of the bot using journalctl -u mybot.
