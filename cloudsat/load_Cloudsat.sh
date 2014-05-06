#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance

python manage.py ngeo_browse_layer --add /var/vmanip/data/cloudsat/Cloudsat_browselayer.xml

tmpdir=`mktemp -d`

find /var/vmanip/data/cloudsat/ -name 'cloudsat_2014012*' -exec unzip {} -d ${tmpdir} \;
#find /var/vmanip/data/cloudsat/ -name 'cloudsat_20140124150000_37519.zip' -exec unzip {} -d ${tmpdir} \;

find ${tmpdir} -name '*tif' -exec mv {} /var/www/store/ \;

find ${tmpdir} -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;

rm -rf ${tmpdir}