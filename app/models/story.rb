class Story
  def self.build_from(user_uuid:)
    current_user = User.find_by(user_uuid: user_uuid)
    story = []
    until current_user.parent.nil?
      story << current_user.tale
      current_user = current_user.parent
    end
    story << current_user.tale
    story.reverse
  end
end
