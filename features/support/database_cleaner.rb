OPTIONS = {type: :server_db, path: "http://localhost:7474", basic_auth: {username: "neo4j", password: "password"}}.freeze
DatabaseCleaner[:neo4j, connection: options].strategy = :deletion

Around do |_scenario, block|
  DatabaseCleaner.cleaning(&block)
end
