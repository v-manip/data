#!/bin/sh

tmpdir=`mktemp -d`

find /home/santilland/ -name 'cryoland.tar.gz' -exec tar -xvf {} -C ${tmpdir} \;

find ${tmpdir} -name "*.tif" | while read F ; do sudo python manage.py eoxs_dataset_register -r Grayscale -d $F -m ${F//.tif/.tif.xml} --series daily_FSC_PanEuropean_Optical ; done

rm -rf ${tmpdir}