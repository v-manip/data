#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/ALARO/ALARO_Specific_Humidity.xml
echo "Loaded ALARO Browse Layer Specific Humidity"

python manage.py ngeo_browse_layer --add /var/vmanip/data/ALARO/ALARO_Temperature_isobaric.xml
echo "Loaded ALARO Browse Layer Temperature Isobaric"

python manage.py ngeo_browse_layer --add /var/vmanip/data/ALARO/ALARO_Temperature_surface.xml
echo "Loaded ALARO Browse Layer Temperature Surface"

python manage.py ngeo_browse_layer --add /var/vmanip/data/ALARO/ALARO_Surface_Pressure.xml
echo "Loaded ALARO Browse Layer Surface Pressure"


find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Specific_hu*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Specific_hu*.xml" -exec python manage.py ngeo_ingest {} -v3 \;

find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Temperature_isoba*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Temperature_isoba*.xml" -exec python manage.py ngeo_ingest {} -v3 \;

find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Temperature_surface*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Temperature_surface*.xml" -exec python manage.py ngeo_ingest {} -v3 \;

find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Surface_Pressure*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase1-2/model/ALARO -name "*Surface_Pressure*.xml" -exec python manage.py ngeo_ingest {} -v3 \;