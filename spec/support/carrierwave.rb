CarrierWave.configure do |config|
  config.enable_processing = false
end

def uploaded_file(path)
  file = File.open(Rails.root.join('spec', 'fixtures', path))
  Rack::Test::UploadedFile.new(file)
end
