#!/bin/sh
EVALFORM_ADMIN="${EVALFORM_ADMIN:-admin@evalform.com}"
EVALFORM_ADMIN_PASSWORD="${EVALFORM_ADMIN_PASSWORD:-GEYyHaLz24CLogdi6x6E}"

sleep 10
php spark migrate --all
(echo -e "$EVALFORM_ADMIN_PASSWORD\n$EVALFORM_ADMIN_PASSWORD") | php spark shield:user create -n admin -e $EVALFORM_ADMIN
echo "y" | php spark shield:user addgroup -n admin -g superadmin