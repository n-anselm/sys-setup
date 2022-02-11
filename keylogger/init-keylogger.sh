#!/bin/bash

KEYLOGFILE=/home/arch/Logs/keylogs.log
if [ -f "$KEYLOGFILE" ]; then
	echo "Keylog file exists"
else
	touch /home/arch/Logs/keylogs.log
fi

if [ -z $(ps ax | awk '! /awk/ && /keylogger.py/ { print $1}') ]; then
	echo "Keylogger not running"

	echo ---------- LOGIN - $(date +%A), $(date +%B%e), $(date +%Y) \| $(date +%H):$(date +%M) ---------- >> $KEYLOGFILE

	python3 /home/arch/exec/keylogger/keylogger.py &
	disown

	echo "Started service"
	notify-send "Keylogger initiated"
else
	echo "Service is already active"
	notify-send "Keylogger initiated"
	echo ---------- MANUAL ACTIVATION - $(date +%A), $(date +%B%e), $(date +%Y) \| $(date +%H):$(date +%M) ---------- >> $KEYLOGFILE
fi

