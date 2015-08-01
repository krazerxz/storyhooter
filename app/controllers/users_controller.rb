class UsersController < ApplicationController
  # Get given a uuid when creating a user
  def new
    parent_user = User.find_by(uuid: referral_uuid)
    story_so_far = Story.build_from(uuid: referral_uuid)
    @user_display = UserDisplay.new(parent: parent_user, story: story_so_far)
  end

  def create
    user_hash = user_params
    referrer_uuid = user_hash.delete(:referrer_uuid)
    referrer_id = User.find_by(uuid: referrer_uuid).id
    @user = User.new(user_hash.merge(referrer_id: referrer_id))
    redirect_to @user if @user.save
    render :new unless @user.save
  end

  # Get given id of newly created user
  def show
    @user = User.find(user_id)
    parent_user = User.find(@user.referrer_id)
    story_so_far = Story.build_from(uuid: @user.uuid)
    @user_display = UserDisplay.new(parent: parent_user, story: story_so_far)
  end

  private

  # for create
  def user_params
    params.require(:user).permit(:name, :country_id, :tale, :referrer_uuid)
  end

  # for show
  def user_id
    params[:id]
  end

  # for new, create
  def referral_uuid
    params[:referred_from]
  end
end
