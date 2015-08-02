class UsersController < ApplicationController
  # Get given a uuid when creating a user
  def new
    parent_user = User.find_by(user_uuid: referral_uuid)
    story_so_far = Story.build_from(user_uuid: referral_uuid)
    @user_display = UserDisplay.new(parent: parent_user, story: story_so_far)
  end

  def create
    user_hash = user_params
    parent_uuid = user_hash.delete(:parent_uuid)
    @user = User.create(user_hash)

    parent = User.find_by(user_uuid: parent_uuid)
    @user.add_parent parent
    parent.add_child @user

    redirect_to user_url(user_uuid: @user.user_uuid) if @user.save
    render :new unless @user.save
  end

  # Get given id of newly created user
  def show
    @user = User.find_by(user_uuid: user_uuid)
    story_so_far = Story.build_from(user_uuid: @user.user_uuid)
    @user_display = UserDisplay.new(parent: @user.parent, story: story_so_far)
  end

  private

  # for create
  def user_params
    params.require(:user).permit(:name, :country_id, :tale, :parent_uuid)
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
