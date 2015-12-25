#!/bin/bash

TO_NUMBER="$1"
SUBJECT="$2"
MESSAGE="$3"

. /usr/local/etc/zabbix-smsru.conf

SMS_URL=${SMS_URL:-"https://sms.ru/sms/send"}

TO_NUMBER=$(echo "${TO_NUMBER}" | sed 's/[^0123456789]//g')

NL='
'

RESULT=$(curl --get --silent --show-error \
    --data-urlencode "api_id=${API_ID}" \
    --data-urlencode "to=${TO_NUMBER}" \
    --data-urlencode "text=${SUBJECT}${NL}${MESSAGE}" \
    "${SMS_URL}" 2>&1
)

STATUS=$?

echo ${RESULT}

exit ${STATUS}
