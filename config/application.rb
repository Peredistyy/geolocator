require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Geolocator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.autoload_paths += ["#{config.root}/app/services/"]
    config.autoload_paths += ["#{config.root}/app/commands/"]
    config.autoload_paths += ["#{config.root}/app/command_handlers/"]

    config.to_prepare do
      Rails.configuration.event_store = event_store = RailsEventStore::Client.new

      event_store.subscribe(AddGeoLocationHandler.new, to: [AddGeoLocationCommand])
      event_store.subscribe(RemoveGeoLocationHandler.new, to: [RemoveGeoLocationCommand])
    end
  end
end
