require 'rails_helper'

describe UsersController, type: :controller do
  describe 'Get /users/new?referred_from=:user_uuid' do
    let(:parent_user) { double(:parent_user) }
    let(:story)       { double(:story) }

    before do
      allow(User).to receive(:find_by).with(user_uuid: 'a_hex_code').and_return(parent_user)
      allow(Story).to receive(:build_from).with(user_uuid: 'a_hex_code').and_return(story)
      allow(UserDisplay).to receive(:new).and_return('user_display')
    end

    it 'finds the referring user' do
      expect(User).to receive(:find_by).with(user_uuid: 'a_hex_code')
      get :new, referred_from: 'a_hex_code'
    end

    it 'builds the story from the referring user' do
      expect(Story).to receive(:build_from).with(user_uuid: 'a_hex_code')
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
    let(:user_details) { { name: 'user', country_id: '1', tale: 'story', parent_uuid: 'parent_uuid' } }
    let(:parent_user)  { double(:parent_user) }
    let(:new_user)     { double(:new_user, user_uuid: '') }

    before do
      allow(User).to receive(:find_by).with(user_uuid: 'parent_uuid').and_return(parent_user)
      allow(User).to receive(:create).and_return(new_user)
      allow(new_user).to receive(:save)
      allow(new_user).to receive(:add_parent)
      allow(parent_user).to receive(:add_child)
    end

    it 'creates the new user with details from the new user form' do
      expect(User).to receive(:create).with(name: 'user', country_id: '1', tale: 'story')
      post :create, user: user_details
    end

    it 'finds the parent user' do
      expect(User).to receive(:find_by).with(user_uuid: 'parent_uuid')
      post :create, user: user_details
    end

    it 'adds the parent to the user' do
      expect(new_user).to receive(:add_parent).with(parent_user)
      post :create, user: user_details
    end

    it 'adds the user as a child to the parent' do
      expect(parent_user).to receive(:add_child).with(new_user)
      post :create, user: user_details
    end
  end

  describe 'get /users/show' do
    let(:parent_user) { double(:parent_user) }
    let(:current_user) { double(:current_user, user_uuid: 'uuid', parent: parent_user) }

    before do
      allow(User).to receive(:find_by).with(user_uuid: 'uuid').and_return(current_user)
      allow(Story).to receive(:build_from).and_return('story')
    end

    it 'finds the user to show' do
      expect(User).to receive(:find_by).with(user_uuid: 'uuid')
      get :show, user_uuid: 'uuid'
    end

    it 'builds the story' do
      expect(Story).to receive(:build_from).with(user_uuid: 'uuid')
      get :show, user_uuid: 'uuid'
    end

    it 'creates a user display' do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: 'story')
      get :show, user_uuid: 'uuid'
    end
  end
end
