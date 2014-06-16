#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/GOME/GOME_browselayer.xml
echo "Loaded GOME browse layer"


find /home/sistema/DATA/useCase5/NP_L2_GOME2/20140513_1700 -name "*.tif" -exec cp {} /var/www/ngeo/store/ \;
find /home/sistema/DATA/useCase5/NP_L2_GOME2/20140513_1700 -name "*.xml" -exec python manage.py ngeo_ingest {} -v3 \;


