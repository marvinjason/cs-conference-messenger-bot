unless Rails.env.production?

	ENV['ACCESS_TOKEN'] = 'EAAB3Pz09wlkBANdaUA26ZCOscyhyGgM0dttYPGfrzDh0XSpHtqjNyX9O3Mam1imlL2vrIDzrDTlGOzZAPm5EZB07mtlN4STIiLKblslTwQjqsP4kGLnSBeiQI4ZB4W1OA4bMbXopr93kFBpz4CNsL0X5RtZAgQty7DXYb2LiaJwZDZD'
	ENV['APP_SECRET'] = 'c758d755071cacc114372bb2e0cf1ddc'
	ENV['VERIFY_TOKEN'] = '123Qwe1!'

  bot_files = Dir[Rails.root.join('app', 'bot', '**', '*.rb')]
  bot_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each{ |file| require_dependency file }
  end

  ActionDispatch::Callbacks.to_prepare do
    bot_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end