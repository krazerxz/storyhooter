class UserDisplay
  attr_reader :story, :future_story

  def initialize parent: [], story:, future_story: []
    @parent = parent
    @story = story
    @future_story = future_story
  end

  def parent_name
    @parent.name
  end

  def parent_uuid
    @parent.user_uuid
  end

  def total_users
    User.all.count
  end
end
