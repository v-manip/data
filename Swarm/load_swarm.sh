#!/bin/sh

cd /var/www/ngeo/ngeo_browse_server_instance/


python manage.py ngeo_browse_layer --add /var/vmanip/data/Swarm/SW_OPER_MAGA_LR_1B_layer.xml
python manage.py ngeo_browse_layer --add /var/vmanip/data/Swarm/SW_OPER_MAGB_LR_1B_layer.xml
python manage.py ngeo_browse_layer --add /var/vmanip/data/Swarm/SW_OPER_MAGC_LR_1B_layer.xml


tmpdir=`mktemp -d`

find /var/vmanip/data/Swarm/ -name 'browses.tar.gz' -exec tar -xzvf {} -C ${tmpdir} \;

find ${tmpdir} -name '*tif' -exec mv {} /var/www/ngeo/store/browses/ \;

find ${tmpdir} -name '*xml' -exec python manage.py ngeo_ingest {} -v3 \;

rm -rf ${tmpdir}