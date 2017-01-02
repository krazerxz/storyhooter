ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "spec_helper"
require "rspec/rails"

Dir[Rails.root.join("app/**/*.rb")].each do |f| require f end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  OPTIONS = {type: :server_db, path: "http://localhost:7474", basic_auth: {username: "neo4j", password: "password"}}.freeze
  DatabaseCleaner[:neo4j, connection: options].strategy = :deletion

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
