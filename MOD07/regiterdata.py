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

print "python " + instance_path + "manage.py eoxs_dataset_register"
print "-r %s -d %s -m %s --series %s -e '%s' -p %s"%(rangetype, getpath(filename), getpath(meta), series, extent, projection)


#call(["ls", "-l"])