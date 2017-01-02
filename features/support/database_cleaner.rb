DatabaseCleaner[:neo4j, connection: {type: :server_db, path: 'http://localhost:7474', basic_auth: {username: "neo4j", password: "password"} }].strategy = :deletion

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end
