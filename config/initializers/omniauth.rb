Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :google_oauth2, '299568666309-7r3vtot8gn7kaujuoudb1ij0eibpq8ng.apps.googleusercontent.com', 'bLlv87VCLuG3-Ct0cutgRO0U', scope: 'userinfo.profile,youtube'
end