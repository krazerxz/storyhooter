require 'securerandom'

class User
  include Neo4j::ActiveNode

  class Parent
    include Neo4j::ActiveRel

    from_class User
    to_class User
    type 'parent'
  end

  class Child
    include Neo4j::ActiveRel

    from_class User
    to_class User
    type 'child'
  end

  property :name
  property :country_id
  property :user_uuid
  property :tale

  has_one :out, :parent, rel_class: Parent,  model_class: User
  has_many :out, :children, rel_class: Child,  model_class: User

  def add_child(user)
    children << user
  end

  def add_parent(user)
    self.parent = user
  end

  before_save do
    self.user_uuid = SecureRandom.hex(5) if user_uuid.nil?
  end

  def referral_url
    "/user/new?referred_from=#{user_uuid}"
  end
end
