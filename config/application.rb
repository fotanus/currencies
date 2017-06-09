require_relative 'boot'

require 'rails/all'

if ENV["ALPHAVANTAGE_API_KEY"].nil?
  puts "You need to set the environment variable ALPHAVANTAGE_API_KEY to run this app."
  exit 1
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Currencies
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
