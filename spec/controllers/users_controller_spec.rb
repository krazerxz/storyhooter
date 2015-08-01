require 'rails_helper'

describe UsersController, type: :controller do
  describe 'Get /users/new?referred_from=:uuid' do
    let(:parent_user) { double(:parent_user) }
    let(:story)       { double(:story) }

    before do
      allow(User).to receive(:find_by).with(uuid: 'a_hex_code').and_return(parent_user)
      allow(Story).to receive(:build_from).with(uuid: 'a_hex_code').and_return(story)
      allow(UserDisplay).to receive(:new).and_return('user_display')
    end

    it 'finds the referring user' do
      expect(User).to receive(:find_by).with(uuid: 'a_hex_code')
      get :new, referred_from: 'a_hex_code'
    end

    it 'builds the story from the referring user' do
      expect(Story).to receive(:build_from).with(uuid: 'a_hex_code')
      get :new, referred_from: 'a_hex_code'
    end

    it 'creates a user display' do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: story)
      get :new, referred_from: 'a_hex_code'
    end

    xit 'handles when an invalid referral code is given' do
      get '/user/new?referred_from=an_invalid_hex'
    end

    xit 'handles when no referral code is given' do
      get '/user/new'
    end
  end

  describe 'Post /users/create' do
    let(:user_details) { { name: 'user', country_id: '1', tale: 'story', referrer_uuid: 'parent_uuid' } }
    let(:parent_user)  { double(:parent_user, id: 99) }
    let(:new_user)     { double(:new_user) }

    before do
      allow(User).to receive(:find_by).with(uuid: 'parent_uuid').and_return(parent_user)
      allow(User).to receive(:new).and_return(new_user)
      allow(new_user).to receive(:save)
    end

    it 'finds the parent user' do
      expect(User).to receive(:find_by).with(uuid: 'parent_uuid')
      post :create, user: user_details
    end

    it 'makes the new user with entered details and parent uuid' do
      expect(User).to receive(:new).with(name: 'user', country_id: '1', tale: 'story', referrer_id: 99)
      post :create, user: user_details
    end

    it 'saves the new user' do
      expect(new_user).to receive(:save)
      post :create, user: user_details
    end
  end

  describe 'get /users/show' do
    let(:current_user) { double(:current_user, referrer_id: 1, uuid: 'uuid') }
    let(:parent_user) { double(:parent_user) }

    before do
      allow(User).to receive(:find).with('2').and_return(current_user)
      allow(User).to receive(:find).with(1).and_return(parent_user)
      allow(Story).to receive(:build_from).and_return('story')
    end

    it 'finds the user to show' do
      expect(User).to receive(:find).with('2')
      get :show, id: 2
    end

    it 'finds the parent user' do
      expect(User).to receive(:find).with(1)
      get :show, id: 2
    end

    it 'builds the story' do
      expect(Story).to receive(:build_from).with(uuid: 'uuid')
      get :show, id: 2
    end

    it 'creates a user display' do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: 'story')
      get :show, id: 2
    end
  end
end
