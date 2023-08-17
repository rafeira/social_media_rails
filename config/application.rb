require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SocialMediaRails
  class Application < Rails::Application
    config.load_defaults 7.0
    g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
  end
end
