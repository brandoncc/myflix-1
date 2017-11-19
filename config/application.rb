require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
  end
end

Raven.configure do |config|
  config.dsn = 'https://d0e75fe9dd814025a8c9d8f3b971889b:abf7d94968a5447dae1eae49d129a521@sentry.io/247397'
end
