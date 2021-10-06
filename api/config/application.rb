require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.generators do |g|
      g.orm :mongoid
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://test.flak.jp', 'localhost:3000', '127.0.0.1:3000', 'http://40.74.136.199/'
        resource '*', 
          headers: :any, 
          methods: [:get, :post, :patch, :put],
          credentials: true
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
