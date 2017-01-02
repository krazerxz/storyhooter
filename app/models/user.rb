require "securerandom"

class User
  include Neo4j::ActiveNode

  property :country
  property :email, default: ""
  property :name
  property :tale
  property :user_uuid

  has_one :out, :parent, rel_class: :Parent, model_class: User
  has_many :out, :children, rel_class: :Child, model_class: User

  def add_child user
    children << user
  end

  def add_parent user
    self.parent = user
  end

  before_save do
    self.user_uuid = SecureRandom.hex(5) if user_uuid.nil?
  end

  def profile_url
    "/user/#{user_uuid}"
  end

  def referral_url
    "/user/new?referred_from=#{user_uuid}"
  end
end
