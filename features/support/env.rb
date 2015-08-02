require 'cucumber/rails'
ActionController::Base.allow_rescue = false

After do
  delete_neo4j_db
end

def delete_neo4j_db
  Neo4j::Session.current._query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')
end
