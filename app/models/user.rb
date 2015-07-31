require 'securerandom'

class User < ActiveRecord::Base
  validates :uuid, uniqueness: true

  def save
    self.uuid = SecureRandom.hex(5)
    super
  end
end
