require 'rails_helper'

describe UsersController do
  xdescribe 'Get /users/new?referred_by=:id' do
    it 'shows the new user page' do
      get '/users/new?referred_by=a_hex_code'
    end

    it 'handles when an invalid referral code is given' do
      get '/users/new?referred_by=an_invalid_hex'
    end

    it 'handles when no referral code is given' do
      get '/users/new'
    end
  end
end
