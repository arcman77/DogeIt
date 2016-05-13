# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  #dogeify hex color
  COLOR_ARRAY = ['#17f71a','#a314e1', '#F3FF35', '#91ffee','#FFBF00','#f41316']

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # # Create different versions of your uploaded files:
  # version :thumb do
  process :resize_to_fit => [900, 900]
  # end

  process :add_text
  def add_text
    #generate a decent spread for 9 different locations
    coords = [
      [-200 +rand(-100..100),150 +rand(-100..100)],[0+rand(-100..100),150+rand(-100..100)],[200+rand(-100..100),150+rand(-100..100)],
      [-200+rand(-100..100),350+rand(-100..100)],[0+rand(-100..100),350+rand(-100..100)],[200+rand(-100..100),350+rand(-100..100)],
      [-200+rand(-100..100),650+rand(-100..100)],[0+rand(-100..100),650+rand(-100..100)],[200+rand(-100..100),650+rand(-100..100)]
             ]
    coords.shuffle!

    manipulate! do |img|
      img.combine_options do |c|
        c.font "#{::Rails.root}/public/fonts/Impact.ttf"
        c.pointsize 20
        c.gravity "North"
        phrases = model.doge_array.sample(9)
        phrases.each_with_index do |phrase,index|
          coord = coords.pop
          c.pointsize "#{30 + rand(10)}"
          c.stroke "black"
          if index == phrases.length - 1
            c.pointsize "50"
            c.fill "#{COLOR_ARRAY[index % COLOR_ARRAY.length]}"
            c.annotate "#{0},#{0},#{0},#{700}", phrase
          else
            rotation = (0..45).to_a.sample*((-1)**index)
            c.fill "#{COLOR_ARRAY[index % COLOR_ARRAY.length]}"
            c.annotate "#{rotation},#{rotation},#{coord[0]},#{coord[1]}", phrase
          end
        end
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
