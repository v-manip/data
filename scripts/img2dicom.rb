#!/usr/bin/ruby

# Load needed libraries:
require 'dicom'
require 'RMagick'
puts DICOM::VERSION
include DICOM

# Source image files:
files = Array.new
images = Array.new

if ARGV.length == 0
    puts '** Please specify a folder with jpg images! **'
    puts 'Usage: img2dicom.rb folder_with_jpgs'
    exit
end

glob = ARGV[0] + '/*.jpg'
puts glob

files = Dir.glob(glob).sort
puts 'Processing following files:'
puts files
files.each do |file|
  images << Magick::ImageList.new(file)
end

# Create DICOM object and tags:
dcm = DObject.new
dcm.transfer_syntax = '1.2.840.10008.1.2.4.50'
dcm.sop_class_uid = '1.2.840.10008.5.1.4.1.1.3.1'
dcm.sop_instance_uid = DICOM.generate_uid
dcm.study_date = Time.now.strftime('%Y.%m.%d')
dcm.study_time = Time.now.strftime('%H:%M:%S')
dcm.modality = 'US'
dcm.manufacturer = 'ruby-dicom'
dcm.patients_name = 'Test'
dcm.patient_id = '12345'
dcm.study_instance_uid = DICOM.generate_uid
dcm.series_instance_uid = DICOM.generate_uid
dcm.study_id = '1'
dcm.series_number = '32'
dcm.instance_number = '142'
dcm.image_position_patient = "0.0\\0.0\\0.0"
dcm.image_orientation_patient = "1\\0\\0\\0\\1\\0"
dcm.frame_of_reference_uid = DICOM.generate_uid
dcm.samples_per_pixel = 1
dcm.photometric_interpretation = 'MONOCHROME1'
dcm.number_of_frames = images.length
dcm.rows = 60
dcm.columns = 30
dcm.series_instance_uid = "1.0\\1.0"
dcm.bits_allocated = 8
dcm.bits_stored = 8
dcm.high_bit = 7
dcm.pixel_representation = 0

## Extra header entries for testing:
# dcm['0028,0004'].value = 'MONOCHROME1'
# dcm.image_type = 'MONOCHROME1'
# dcm['0008,0008'].value = 'MONOCHROME1'

# Create pixel tags/items:
pixel_data_seq = Sequence.new('7FE0,0010', :parent => dcm, :vr => 'OB')
basic_offset_table_item = Item.new(:length => 0, :parent => pixel_data_seq)
images.each do |image|
  frame_item = Item.new(:bin => image.to_blob, :parent => basic_offset_table_item)
end

# Write DICOM object to file:
dcm.write('result.dcm')
