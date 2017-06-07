require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Knewmark
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_view.sanitized_allowed_tags = Rails::Html::WhiteListSanitizer.allowed_tags + %w(table tr td)
    config.action_view.sanitized_allowed_attributes = Rails::Html::WhiteListSanitizer.allowed_attributes + %w(style border)
    config.autoload_paths += %W[#{Rails.root}/lib]

    config.generators do |generator|
      generator.assets false
      generator.test_framework false
      generator.skip_routes true
    end
  end
end
