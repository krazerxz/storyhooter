class Story
  def self.build_to_top_from(user_uuid:)
    current_user = User.find_by(user_uuid: user_uuid)
    parent_chain = current_user.parent(rel_length: { min: 0 })
    parent_chain.map { |user| build_hash_from(user) }.reverse
  end

  def self.build_down_from(user_uuid:)
    current_user = User.find_by(user_uuid: user_uuid)
    return [] if current_user.children.count.zero?
    story = []
    until current_user.children.count.zero?
      current_user = current_user.children.result.sample
      story << build_hash_from(current_user)
    end
    story
  end

  def self.build_hash_from(user)
    h = {}
    h[:tale] = user.tale
    h[:name] = user.name
    h[:country] = user.country
    h
  end

  private_class_method :build_hash_from
end
