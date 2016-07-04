Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["169621049650-n6dpqvvtkqpmhasc35ob293j28ejugbg.apps.googleusercontent.com"], ENV["0W_Mr91ntx4DeG2MjI38qxaq"],
         scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online'
end