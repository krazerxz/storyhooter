require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module StoryHooter
  class Application < Rails::Application
    Figaro.load
    options = { basic_auth: { username: Figaro.env.neo4j_username, password: Figaro.env.neo4j_password }}
    Neo4j::Session.open(:server_db, Figaro.env.neo4j_url, options)
  end
end
