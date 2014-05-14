#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance/


python manage.py ngeo_browse_layer --add /var/vmanip/data/Swarm/Swarm_browselayer.xml

tmpdir=`mktemp -d`

find /var/vmanip/data/Swarm/ -name 'swarm-browses*' -exec tar -xzvf {} -C ${tmpdir} \;

find ${tmpdir} -name '*tif' -exec mv {} /var/www/ngeo/store/ \;

find ${tmpdir} -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;

rm -rf ${tmpdir}