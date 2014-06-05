#!/bin/sh


find ${tmpdir} -name "*.tif.xml" | while read F ; do  python extract.py $F $F; done
find ${tmpdir} -name "*.tif" | while read F ; do sudo python manage.py eoxs_dataset_register -r Grayscale -d $F -m  ${F//.tif/.tif.xml} --series daily_FSC_PanEuropean_Optical ; done

