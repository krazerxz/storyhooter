class UsersController < ApplicationController
  def new
    referral_user = User.find_by(uuid: referred_from)
    @referral_user = referral_user.name
    @story_so_far = Story.build_from(uuid: @referral_user)
  end

  private

  def referred_from
    params[:referred_from]
  end
end
