lighttpd -D -f /etc/lighttpd/lighttpd.conf &
/usr/local/sbin/nerd-gpios.sh
/usr/local/sbin/nerd-alarmclock.py

trap 'kill $(jobs -p)' EXIT
