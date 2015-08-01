class UserDisplay
  def initialize(parent:, story:)
    @parent = parent
    @story = story
  end

  def referrer_name
    @parent.name
  end
end
