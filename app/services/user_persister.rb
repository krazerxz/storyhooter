class UserPersister
  def initialize user_params
    @params = user_params
  end

  def create
    user = User.create(user_params)
    user.add_parent user_parent
    user_parent.add_child user
  end

  private

  def user_params
    {
      user: @params[:name],
      country: country,
      tale: @params[:tale],
      email: @params[:email]
    }
  end

  def user_parent
    User.find_by user_uuid: @params[:parent_uuid]
  end

  def country
    country_id = @params[:country_id].to_i
    Country.for country_id
  end
end
