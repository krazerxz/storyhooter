class UserPersister
  def self.create_from(user_params)
    country_id = user_params.delete(:country_id).to_i
    user_params[:country] = Country.for country_id
    User.create(user_params)
  end
end
