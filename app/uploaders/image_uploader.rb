# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  
  process :resize_to_limit => [700,700]
  
  process :convert => 'jpg'
  
  version :thumb do
    process :resize_to_limit => [300,300]
  end
  
  def extension_while_list
    %w(jpg jpeg gif png)
  end
  
end
