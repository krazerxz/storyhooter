class User < ActiveRecord::Base

  def save
    self.uuid = SecureRandom.hex(5)
    super
  end
end
