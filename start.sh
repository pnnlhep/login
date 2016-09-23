#!/bin/bash -e
(
if [ "x$START_WAIT_FILE" != "x" ]; then
	while true; do
		[ -f "$START_WAIT_FILE" ] && break
		sleep 1
	done
fi
if [ -x /srv/start/setup.sh ]
then
	. /srv/start/setup.sh
fi
if [ ! -f /etc/ssh/ssh_host_dsa_key ]
then
	/etc/init.d/sshd start
	/etc/init.d/sshd stop
fi
exec /usr/sbin/sshd -D $OPTIONS
) & pid=$!
trap "kill $pid" TERM
echo $pid > /var/run/ssh.pid
if [ "x$START_WAIT_DONE_FILE" != "x" ]; then
	touch "$START_WAIT_DONE_FILE"
fi
wait $pid
while true; do
	ps -eo cmd | grep ^sshd | grep -v grep
        [ $? -ne 0 ] && break
        sleep 1
done
[ -f /etc/shutdown.sh ] && bash /etc/shutdown.sh
