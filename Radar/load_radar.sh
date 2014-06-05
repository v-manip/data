#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/Radar/Radar_browselayers.xml
echo "Loaded Radar Browse Layers"


find /home/sistema/DATA/useCase4/Radar/ -name "*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase4/Radar/ -name "*.xml" -exec python manage.py ngeo_ingest {} -v3 \;
