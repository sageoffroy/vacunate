require_relative 'boot'

require 'csv'
require 'rails/all'

Bundler.require(*Rails.groups)

module Vacunate
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.default_locale = :es
    I18n.available_locales = [:es]

    config.generators do |g|
        g.stylesheets false
    end
    config.action_controller.default_protect_from_forgery = false
    config.serve_static_assets = true

  end
end
