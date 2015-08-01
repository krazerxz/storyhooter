class UserDisplay
  attr_reader :story

  def initialize(parent:, story:)
    @parent = parent
    @story = story
  end

  def referrer_name
    @parent.name
  end

  def referrer_uuid
    @parent.uuid
  end

  def total_users
    User.all.count
  end
end
