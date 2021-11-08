# servers_monitoring
Simple bash script for monitoring and mail notification about servers status

1. Create .env file in project root and update following variables up to your environment:

```sh
# List of servers for monitoring:
SERVERS_LIST="~/servers_monitoring/servers.txt"

# File where servers down will be added:
SERVERS_DOWN_LIST="~/servers_monitoring/servers_down.txt"

# Notification script:
NOTIFY_SCRIPT="~/servers_monitoring/notify.sh"

# Mail where notification should be sent:
MESSAGE_TO="admin@example.com"
```

2. Add following tasks to your cron:
```sh
# run monitoring script every 15 minutes & and log results:
*/15 * * * * bash ~/servers_monitoring/monitor.sh >> /tmp/servers_monitoring.log

# send mail notification every morning at 08:01
1 8 * * * mail -s "SERVERS MONITORING: OK" admin@example.com < /tmp/servers_monitoring.log

# clean monitoring log at 08:02
2 8 * * * echo -n "" > /tmp/servers_monitoring.log
```

## P.S.: Don't forget to setup mail/sendMail on your server!
