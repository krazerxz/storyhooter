require 'securerandom'

class User
  include Neo4j::ActiveNode

  class ReferFrom
    include Neo4j::ActiveRel

    from_class User
    to_class User
    type 'referred_from'
  end

  class ReferTo
    include Neo4j::ActiveRel

    from_class User
    to_class User
    type 'referred_to'
  end

  property :name
  property :country_id
  property :user_uuid
  property :tale

  has_many :out, :refer_to, rel_class: ReferTo,  model_class: User
  has_many :in, :refer_from, rel_class: ReferFrom,  model_class: User

  def add_refer_to(user)
    refer_to << user unless refer_to.include? user
  end

  #before_save do |_user|
  #self.uuid = SecureRandom.hex(5)
  #end

  def referral_url
    "/user/new?referred_from=#{uuid}"
  end
end
