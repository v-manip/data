#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/AROME/AROME_Specific_Humidity.xml
echo "Loaded AROME Browse Layer Specific Humidity"

python manage.py ngeo_browse_layer --add /var/vmanip/data/AROME/AROME_Temperature_isobaric.xml
echo "Loaded AROME Browse Layer Temperature Isobaric"


find /home/sistema/DATA/useCase1-2/model/AROME -name "*Specific_hu*.tif" -exec cp {} /var/www/ngeo/store/ \;

find /home/sistema/DATA/useCase1-2/model/AROME -name "*Specific_hu*.xml" -exec python manage.py ngeo_ingest {} -v3 \;


find /home/sistema/DATA/useCase1-2/model/AROME -name "*Temperature_isoba*.tif" -exec cp {} /var/www/ngeo/store/ \;

find /home/sistema/DATA/useCase1-2/model/AROME -name "*Temperature_isoba*.xml" -exec python manage.py ngeo_ingest {} -v3 \;