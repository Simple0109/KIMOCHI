require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kimochi3
  class Application < Rails::Application
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.{rb,yml}").to_s]
    config.assets.initialize_on_precompile = false
    config.active_storage.variant_processor = :vips
    config.active_job.queue_adapter = :delayed_job

    config.generators do |g|
      g.asset false
      g.skip_routes false
      g.helper false
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
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
