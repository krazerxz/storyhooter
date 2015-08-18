class Story
  def self.build_to_top_from(user_uuid:)
    current_user = User.find_by(user_uuid: user_uuid)
    story = []
    until current_user.parent.nil?
      story << build_hash_from(current_user)
      current_user = current_user.parent
    end
    story << build_hash_from(current_user)
    story.reverse
  end

  def self.build_down_from(user_uuid:)
    current_user = User.find_by(user_uuid: user_uuid)
    return [] if children_for(current_user).count.zero?
    story = []
    until children_for(current_user).count.zero?
      current_user = children_for(current_user).sample
      story << current_user.tale
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

  def self.children_for(user)
    user.children.execute
    user.children
  end

  private_class_method :children_for
end
