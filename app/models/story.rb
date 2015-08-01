class Story
  def self.build_from(uuid:)
    current_user = User.find_by(uuid: uuid)
    story = []
    until current_user.referrer_id.nil?
      story << current_user.tale
      current_user = User.find_by(id: current_user.referrer_id)
    end
    story << current_user.tale
    story.reverse
  end
end
