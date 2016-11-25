require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CurrencyCoverter
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.configure do |env|
      if Rails.env.development? || Rails.env.test?
        env.cache = ActiveSupport::Cache.lookup_store(:memory_store)
      end
    end
  end
end
