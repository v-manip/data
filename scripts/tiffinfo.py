#!/usr/bin/python2

import gdal
from gdalconst import *
import struct
import sys

src_filename = sys.argv[1]
print "Analysing file: ", src_filename

dataset = gdal.Open(src_filename, GA_ReadOnly)

print 'Driver: ', dataset.GetDriver().ShortName,'/', \
          dataset.GetDriver().LongName
print 'Size is ',dataset.RasterXSize,'x',dataset.RasterYSize, \
      'x',dataset.RasterCount

band = dataset.GetRasterBand(5);
print 'Band Type=',gdal.GetDataTypeName(band.DataType)

a = band.GetRasterColorTable()
print 'RasterColorTable: ', a

scanline = band.ReadRaster( 0, 0, band.XSize, 1, band.XSize, band.YSize, GDT_Float32 )

tuple_of_floats = struct.unpack('f' * band.XSize * band.YSize, scanline)

min = band.GetMinimum()
max = band.GetMaximum()
if min is None or max is None:
    (min,max) = band.ComputeRasterMinMax(1)
print 'Min=%.3f, Max=%.3f' % (min,max)

print 'Number of floats: ', len(tuple_of_floats)
# print 'Raw values: ', tuple_of_floats
