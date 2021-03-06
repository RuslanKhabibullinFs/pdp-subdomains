require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module PdpSubdomains
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join("lib")
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    config.app_generators.scaffold_controller :responders_controller

    config.load_defaults 5.1
  end
end
