class UserDisplay
  attr_reader :story

  def initialize(parent:, story:)
    @parent = parent
    @story = story
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
