Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  TWITTER_CONFIG['key'],  TWITTER_CONFIG['secret']
  provider :facebook,  FACEBOOK_CONFIG['app_id'],  FACEBOOK_CONFIG['secret'], :setup=> true, :scope => 'read_stream, user_photos'
end
