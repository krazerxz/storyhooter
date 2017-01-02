class Parent
  include Neo4j::ActiveRel

  from_class :User
  to_class :User
  type "parent"
end
