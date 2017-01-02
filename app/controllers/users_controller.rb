UserException = Class.new(Exception)

class UsersController < ApplicationController
  # Get given a uuid when creating a user
  def new
    parent_user = User.find_by(user_uuid: referral_uuid)
    raise UserException, "The referrer you entered does not exist" if parent_user.nil?
    story_so_far = Story.build_to_top_from(user_uuid: referral_uuid)
    @user_display = UserDisplay.new(parent: parent_user, story: story_so_far)
  end

  def create
    @user = UserPersister.new(user_params).create
    NewUserMailer.new_user_email(@user).deliver_now unless @user.email.empty? # WHY CANT I REMOVE THIS
    @user.send_welcome_email
    redirect_to user_url(user_uuid: @user.user_uuid)
  end

  # Get given id of newly created user
  def show
    @user = User.find_by(user_uuid: user_uuid)
    raise UserException, "The user you entered does not exist" if @user.nil?
    story_so_far = Story.build_to_top_from(user_uuid: @user.user_uuid)
    future_story = Story.build_down_from(user_uuid: @user.user_uuid)
    @user_display = UserDisplay.new(parent: @user.parent, story: story_so_far, future_story: future_story)
  end

  private

  # for create
  def user_params
    params.require(:user).permit(:name, :country_id, :tale, :parent_uuid, :email)
  end

  # for show
  def user_uuid
    params[:user_uuid]
  end

  # for new, create
  def referral_uuid
    params[:referred_from]
  end
end
