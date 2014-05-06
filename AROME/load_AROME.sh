#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/AROME/AROME_browselayer.xml


#find /home/sistema/DATA/useCase1-2/model/AROME -name '*tif' -exec cp {} /var/www/store/ \;
find /home/sistema/DATA/useCase1-2/model/AROME/20130515/00 -name '*tif' -exec cp {} /var/www/store/ \;

#find /home/sistema/DATA/useCase1-2/model/AROME -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;
find /home/sistema/DATA/useCase1-2/model/AROME/20130515/00 -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;