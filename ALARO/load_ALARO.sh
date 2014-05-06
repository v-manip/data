#!/bin/sh

#cd /var/www/ngeo/ngeo_browse_server_instance
cd /var/ngeob_autotest

python manage.py ngeo_browse_layer --add /var/vmanip/data/ALARO/ALARO_browselayer.xml
echo "Loaded ALARO Browse Layer"


#find /home/sistema/DATA/useCase1-2/model/ALARO -name '*tif' -exec cp {} /var/www/store/ \;
#find /home/sistema/DATA/useCase1-2/model/ALARO/20130515/00 -name '*tif' -exec cp {} /var/www/store/ \;
find /var/vmanip/data/examples/exampledata/ALARO -name '*tif' -exec cp {} /var/www/store/ \;

#find /home/sistema/DATA/useCase1-2/model/ALARO -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;
#find /home/sistema/DATA/useCase1-2/model/ALARO/20130515/00 -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;
find  /var/vmanip/data/examples/exampledata/ALARO -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;