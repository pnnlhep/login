#!/bin/bash -e
if [ -x /srv/start/setup.sh ]
then
	. /srv/start/setup.sh
fi
if [ ! -f /etc/ssh/ssh_host_dsa_key ]
then
	/etc/init.d/sshd start
	/etc/init.d/sshd stop
fi
/usr/sbin/sshd -D $OPTIONS
