require 'securerandom'

class User < ActiveRecord::Base
  validates :uuid, uniqueness: true

  before_save do |_user|
    self.uuid = SecureRandom.hex(5)
  end
end
