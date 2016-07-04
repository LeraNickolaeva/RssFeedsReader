class AvatarUploader < BaseUploader

  version :basic do
    process resize_to_fit: [200, 200]
  end

  version :large do
    process resize_to_fit: [400,400]
  end

  version :small do
    process resize_to_fit: [100,100]
  end

  version :thumb do
    process resize_to_fit: [20, 20]
  end
end
