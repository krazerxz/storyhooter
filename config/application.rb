require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module StoryHooter
  class Application < Rails::Application
    neo4j_dbconfig = YAML.load(File.open("#{File.dirname(__FILE__)}/neo4j_database.yml"))[ENV['RAILS_ENV']]
    Neo4j::Session.open(:server_db, neo4j_dbconfig['database_url'])
  end
end
