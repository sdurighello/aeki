# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Create thumbnail version with upload
  version :thumbnail do
        eager
        resize_to_fit(300, 300)
        cloudinary_transformation :quality => 80
    end
end
