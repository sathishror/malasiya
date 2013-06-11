Melaka::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log
  
  #For invalid authenticity token devise
  #  config.action_controller.allow_forgery_protection = false

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  require 'yaml'
  @mailer_config = YAML::load(File.open(Rails.root.join("config/mailer.yml")))[Rails.env]
  config.action_mailer.default_url_options = { :host => @mailer_config['host'] }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => @mailer_config['user_name'],
    :password             => @mailer_config['password'],
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
  APP_URL="http://localhost:3000"
  MAIN_SITE_URL="http://localhost:3000"
  SPREFIX = YAML::load(File.open(Rails.root.join("config", "stalker.yml")))[Rails.env]["stalker_prefix"]
  
end

