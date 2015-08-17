require 'rails_helper'

describe HomeController do
  describe 'GET #index' do
    let(:user) { double(:user, user_uuid: 1) }

    before do
      allow(User).to receive(:first).and_return user
      allow(Story).to receive(:build_to_top_from).with(user_uuid: 1)
    end

    it 'should load all users' do
      expect(User).to receive(:all)
      get :index
    end

    it 'gets the first user' do
      expect(User).to receive(:first)
      get :index
    end

    it 'builds story to the first user' do
      expect(Story).to receive(:build_to_top_from).with(user_uuid: 1)
      get :index
    end
  end
end
