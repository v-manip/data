import sys
import os


# Set paths
# export PYTHONPATH=/opt/lib/python2.6/site-packages/
# export BUFR_TABLES=/opt/lib/emos/bufrtables/

#Install python buft 
#https://code.google.com/p/python-bufr/wiki/InstallationUbuntu

#Example using pyshp
#http://gis.stackexchange.com/questions/70786/using-the-python-shape-library-pyshp-how-to-convert-polygons-in-csv-file-to

sys.path.append("/opt/lib/python2.6/site-packages/")

import bufr
import shapefile as shp

print sys.argv


pointcollection = {}


list_of_files = {}
for (dirpath, dirnames, filenames) in os.walk(sys.argv[1]):
    for filename in filenames:

        filepath = dirpath+filename

        bfr = bufr.BUFRFile(filepath)
        data = bfr.read()

        #Set up blank lists for data
        year, month, day, hour, minute, temp, pressure = [],[],[],[],[],[],[]

        lat = data[4].data[0]
        lon = data[5].data[0]


        #iterate though file using 
        for record in data:
            # iterate through all entries for this record
            #print ", ".join([str(record.index),str(record.name), str(record.data), str(record.unit)])
            if("YEAR" in str(record.unit)):
            	year.append(int(record.data[0]))
            if("MONTH" in str(record.unit)):
            	month.append(int(record.data[0]))
            if("DAY" in str(record.unit)):
            	day.append(int(record.data[0]))
            if("HOUR" in str(record.unit)):
            	hour.append(int(record.data[0]))
            if("MINUTE" in str(record.name)):
            	minute.append(int(record.data[0]))
            if("TEMPERATURE/DRY-BULB TEMPERATURE" in str(record.name)):
            	temp.append(record.data[0])
            if("PRESSURE" in str(record.name)):
            	pressure.append(record.data[0])


        if ((lat,lon) in pointcollection):
            p = pointcollection[(lat,lon)]
            p[0].extend(year)
            p[1].extend(month)
            p[2].extend(day)
            p[3].extend(hour)
            p[4].extend(minute)
            p[5].extend(temp)
            p[6].extend(pressure)
        else:
            pointcollection[(lat,lon)] = [year,month,day,hour,minute,temp,pressure]



#Set up shapefile writer and create empty fields
w = shp.Writer(shp.POINT)
w.autoBalance = 1 #ensures gemoetry and attributes match
w.field('X','F',10,8)
w.field('Y','F',10,8)
w.field('DateTime','T')
w.field('Temperature','F',10,2)
w.field('Pressure','F',10,0)
w.field('ID','N')


for idx, key in enumerate(pointcollection):
    
    pointdata = pointcollection[key]

    #loop through the data and write the shapefile
    lat,lon = key
    for j in range(len(pointdata[0])):
    	w.point(lon,lat) #write the geometry
    	date = ( "%04d%02d%02d%02d%02d"%( pointdata[0][j], pointdata[1][j], pointdata[2][j], pointdata[3][j], pointdata[4][j] ) )
    	w.record(lat, lon, date, pointdata[5][j], pointdata[6][j], idx) #write the attributes
	

#Save shapefile
w.save(sys.argv[2])
