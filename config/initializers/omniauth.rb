require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  # Add some OmniAuth providers in here
  if Rails.env.production?
    provider :github, 'fcb24a26398a6ceb313b', 'de46218c52fc9b289a8b152d035a1caef74ba248'
  else
    provider :github, '11bf57989a0c4fbc0282', 'feea563d56b6fb78d5647b30a0509963ff3d0a63'
  end
end

