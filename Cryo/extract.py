import sys
from lxml import etree


print sys.argv

tree = etree.parse(sys.argv[1])


ns = {
	"eop": "http://www.opengis.net/eop/2.0",
	"gmlcov": "http://www.opengis.net/gmlcov/1.0",
	"wcs": "http://www.opengis.net/wcs/2.0",
	"wcseo": "http://www.opengis.net/wcseo/1.0"
}

eo = tree.xpath(
	"wcs:CoverageDescription[1]/gmlcov:metadata/gmlcov:Extension/wcseo:EOMetadata/eop:EarthObservation",
	namespaces=ns
)[0]
print eo

with open(sys.argv[2], "w") as f:
	f.write(etree.tostring(eo, pretty_print=True))