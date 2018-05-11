#!/bin/sh

set -ex

# Fix permissions
chown root.syslog /var/log /var/spool/rsyslog
chmod 0775 /var/log /var/spool/rsyslog

# Remove stale pid file
rm -f /var/run/rsyslogd.pid || exit 0

FILE="/etc/rsyslog.conf"

# Test if configuration file exists
while [ ! -f "${FILE}" ]; do
  echo "waiting for ${FILE}"
  sleep 5
done

# Finally run Rsyslog
exec /usr/sbin/rsyslogd -n -f /etc/rsyslog.conf

