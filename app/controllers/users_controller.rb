class UsersController < ApplicationController
  # Get given a uuid when creating a user
  def new
    referral_user = User.find_by(uuid: referred_from)
    @referral_user = referral_user
    @story_so_far = Story.build_from(uuid: referral_user.uuid)
  end

  def create
    user_hash = user_params
    referrer_uuid = user_hash.delete(:referrer_uuid)
    referrer_id = User.find_by(uuid: referrer_uuid).id
    @user = User.new(user_hash.merge(referrer_id: referrer_id))
    @user.save
    redirect_to @user
  end

  # Get given id of newly created user
  def show
    @user = User.find(user_id)
    @user_count = User.all.count
    @story_so_far = Story.build_from(uuid: @user.uuid)
  end

  private

  def user_params
    params.require(:user).permit(:name, :country_id, :tale, :referrer_uuid)
  end

  def user_id
    params[:id]
  end

  def uuid
    params[:uuid]
  end

  def referred_from
    params[:referred_from]
  end
end
