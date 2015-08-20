class HomeController < ApplicationController
  def index
    user = User.order(:created_at).limit(1).first
    example_story = Story.build_down_from(user_uuid: user.user_uuid)
    @user_display = UserDisplay.new(story: example_story)
    render 'index'
  end
end
