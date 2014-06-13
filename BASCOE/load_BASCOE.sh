#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/BASCOE/BASCOE_browselayer.xml
echo "Loaded BASCOE browse layer"


find /home/sistema/DATA/useCase5/REAN_MODEL -name "*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase5/REAN_MODEL -name "*.xml" -exec python manage.py ngeo_ingest {} -v3 \;


