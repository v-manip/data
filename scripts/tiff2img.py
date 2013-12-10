#!/usr/bin/python

import gdal
from gdalconst import *
import struct
import sys
import Image

src_filename = sys.argv[1]
print "Analysing file: ", src_filename

dataset = gdal.Open(src_filename, GA_ReadOnly)

print 'Driver: ', dataset.GetDriver().ShortName,'/', \
          dataset.GetDriver().LongName
print 'Size is ',dataset.RasterXSize,'x',dataset.RasterYSize, \
      'x',dataset.RasterCount

for idx in range(0, dataset.RasterCount-1):
# for idx in range(dataset.RasterCount):
    print 'Processing layer: ', idx+1

    band = dataset.GetRasterBand(idx+1);
    print 'Band Type=',gdal.GetDataTypeName(band.DataType)

    scanline = band.ReadRaster( 0, 0, band.XSize, band.YSize, band.XSize, band.YSize, GDT_Float32 )
    # scanline = band.ReadRaster( 0, 0, band.XSize, band.YSize, GDT_Float32 )

    print 'asdf: ', len(scanline)
    tuple_of_floats = struct.unpack('f' * band.XSize * band.YSize, scanline)

    min = band.GetMinimum()
    max = band.GetMaximum()
    if min is None or max is None:
        (min,max) = band.ComputeRasterMinMax(idx)

    # r = max - min
    # low_bound = min
    # if min < 0:
    #     low_bound = min * -1
    #     max + low_bound
    # print 'low_bound=%.3f, range=%.3f' % (low_bound, r)

    def stretch(value):
        res = ((value - min) / (max - min)) * 255
        if res > 255:
            print 'error: ', res
        return int(res)

    grayscale = map(stretch, tuple_of_floats)

    # print 'Raw values: ', tuple_of_floats
    # print 'Gray values: ', grayscale

    ## Print out textual representation of the image:
    # rows = dataset.RasterXSize
    # lines = dataset.RasterYSize
    # input_array = grayscale
    # # input_array = list(tuple_of_floats)

    # for line in range(0, lines):
    #     for row in range(0, rows):
    #         sys.stdout.write(repr(int(input_array[line*lines + row])).rjust(4))
    #     print ' |'

    print 'Number of floats: ', len(tuple_of_floats)
    print 'Number of grayscale: ', len(grayscale)
    print 'Min=%.3f, Max=%.3f' % (min,max)
    # print 'low_bound=%.3f, range=%.3f' % (low_bound, r)

    im = Image.new("L", (dataset.RasterXSize, dataset.RasterYSize))

    pixels = list()
    for item in grayscale:
        pixel = item
        pixels.append(pixel)
        # if item > 50:
            # print pixel
    im.putdata(pixels);

    filename = 'test-0' + str(idx) + '.jpg'
    if idx > 9:
        filename = 'test-' + str(idx) + '.jpg'
    try:
        im.save('export/' + filename, "JPEG")
    except:
           print "HACK: Catching no-effect exception..." 
