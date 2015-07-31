require 'rails_helper'

describe HomeController do
  describe 'GET #index' do
    it 'should load all users' do
      expect(User).to receive(:all)
      get :index
    end
  end
end
