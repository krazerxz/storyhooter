require File.expand_path("../boot", __FILE__)

require "neo4j/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module StoryHooter
  class Application < Rails::Application
    config.generators {|g| g.orm :neo4j }
  end
end
