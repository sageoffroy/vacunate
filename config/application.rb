require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vacunate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.


    config.generators do |g|
<<<<<<< HEAD
        g.stylesheets false
    end
    config.action_controller.default_protect_from_forgery = false
=======
  		g.stylesheets false
	  end

    config.action_controller.default_protect_from_forgery = false

>>>>>>> d36fcef0bd18423def2c0ff6e4845887f9bd3353

  end
end
