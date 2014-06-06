import sys
from lxml import etree

print sys.argv


def clean(s):
	return s.replace('-','').replace('T','').replace(':','').replace('Z','')

tree = etree.parse(sys.argv[1])


ns = {
 	"rep":"http://ngeo.eo.esa.int/schema/browseReport",
	"eop": "http://www.opengis.net/eop/2.0",
	"gmlcov": "http://www.opengis.net/gmlcov/1.0",
	"wcs": "http://www.opengis.net/wcs/2.0",
	"wcseo": "http://www.opengis.net/wcseo/1.0"
}

eo = tree.xpath("/rep:browseReport/rep:browse",namespaces=ns)

bt = tree.xpath("/rep:browseReport/rep:browseType", namespaces=ns)[0].text
beg_time = tree.xpath("/rep:browseReport/rep:browse/rep:startTime", namespaces=ns)[0].text
end_time = tree.xpath("/rep:browseReport/rep:browse/rep:endTime", namespaces=ns)[0].text
footprint = tree.xpath("/rep:browseReport/rep:browse/rep:rectifiedBrowse/rep:coordList", namespaces=ns)[0].text
coords = footprint.split(' ')
poly = " ".join([
	coords[0],coords[1],
	coords[0],coords[3],
	coords[2],coords[3],
	coords[2],coords[1],
	coords[0],coords[1]
])

eoid = bt +'_'+ clean(beg_time)+'_'+clean(end_time)


out = """\
<Metadata>
  <EOID>%s</EOID>
  <BeginTime>%s</BeginTime>
  <EndTime>%s</EndTime>
  <Footprint>
    <Polygon>
      <Exterior>%s</Exterior>
    </Polygon>
  </Footprint>
</Metadata>
"""%(eoid,beg_time,end_time,poly)



with open(sys.argv[2], "w") as f:
	f.write(out)


