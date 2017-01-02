class Child
  include Neo4j::ActiveRel

  from_class :User
  to_class :User
  type "child"
end
