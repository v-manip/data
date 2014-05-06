#!/bin/sh

python manage.py eoxs_rangetype_load -i /var/vmanip/data/SPOT4/SPOT4HRVIR_int16.json
python manage.py eoxs_series_create -i SPOT4_View
python manage.py eoxs_series_create -i SPOT4_Pente

find /home/santilland/v-manip/SPOT4/ -name \*_RGB.TIF | while read F ; do sudo python manage.py eoxs_dataset_register -r RGBA -d $F -m ${F//.TIF/.xml} --series SPOT4_View ; done
find /home/santilland/v-manip/SPOT4/ -name \*_PENTE.TIF | while read F ; do sudo python manage.py eoxs_dataset_register -r SPOT4HRVIR_int16 -d $F -m ${F//.TIF/.xml} --series SPOT4_Pente ; done