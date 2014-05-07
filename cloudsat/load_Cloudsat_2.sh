#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance


find /home/sistema/DATA/useCase4/CLOUDSAT/ -name '*tif' -exec cp {} /var/www/ngeo/store/ \;

find /home/sistema/DATA/useCase4/CLOUDSAT/ -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;
