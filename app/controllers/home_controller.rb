class HomeController < ApplicationController
  def index
    @users = User.all
    user = User.first
    story_so_far = Story.build_to_top_from(user_uuid: user.user_uuid)
    @user_display = UserDisplay.new(story: story_so_far)
    render 'index'
  end
end
