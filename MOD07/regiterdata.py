import sys
import os
from lxml import etree
from subprocess import call

print sys.argv

def getpath(f):
	return os.path.dirname(os.path.realpath(f)) + "/" + f

instance_path = "/var/www/ngeo/ngeo_browse_server_instance/"
rangetype = "MOD07_float32"
projection = "4326"
meta = sys.argv[1]
series = sys.argv[2]
filename = meta.replace("xml","tif")


tree = etree.parse(meta)

footprint = tree.xpath("/Metadata/Footprint/Polygon/Exterior")[0].text

extent = footprint.split(' ')

extent = [
	extent[0],
	extent[1],
	extent[4],
	extent[5]
]


extent = ",".join(extent)

command = ["python", instance_path+"manage.py", "eoxs_dataset_register", "-r", rangetype, "-d", filename, "-m", meta, "--series", series, "-e", extent, "-p", projection]

print command

call(command)



#find /data/MOD07/ -name "*Surface_Pressure*.xml" -exec python regiterdata.py %f MOD07_Surface_Pressure_data \;
#find /data/MOD07/ -name "*Surface_temperature*.xml" -exec python regiterdata.py {} MOD07_Surface_temperature_data \;