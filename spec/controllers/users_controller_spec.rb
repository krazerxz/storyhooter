require 'rails_helper'

describe UsersController, type: :controller do
  describe 'Get /users/new?referred_from=:user_uuid' do
    let(:parent_user) { double(:parent_user) }
    let(:story)       { double(:story) }

    before do
      allow(User).to receive(:find_by).with(user_uuid: 'a_hex_code').and_return(parent_user)
      allow(Story).to receive(:build_to_top_from).with(user_uuid: 'a_hex_code').and_return(story)
      allow(UserDisplay).to receive(:new).and_return('user_display')
    end

    it 'finds the referring user' do
      expect(User).to receive(:find_by).with(user_uuid: 'a_hex_code')
      get :new, referred_from: 'a_hex_code'
    end

    it 'builds the story from the referring user' do
      expect(Story).to receive(:build_to_top_from).with(user_uuid: 'a_hex_code')
      get :new, referred_from: 'a_hex_code'
    end

    it 'creates a user display' do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: story)
      get :new, referred_from: 'a_hex_code'
    end

    context 'invalid users' do
      it 'throws an error if an invalid user is entered' do
        allow(User).to receive(:find_by).with(user_uuid: 'user_does_not_exist').and_return nil
        expect { get :new, referred_from: 'user_does_not_exist' }.to raise_error UserException, 'The referrer you entered does not exist'
      end

      it 'throws an error if no user is entered' do
        allow(User).to receive(:find_by).with(user_uuid: nil).and_return nil
        expect { get :new }.to raise_error UserException, 'The referrer you entered does not exist'
      end
    end
  end

  describe 'Post /users/create' do
    let(:user_details) { { name: 'user', country_id: '1', tale: 'story', parent_uuid: 'parent_uuid', email: 'email@example.com' } }
    let(:parent_user)  { double(:parent_user) }
    let(:new_user)     { double(:new_user, user_uuid: '') }

    before do
      allow(User).to receive(:find_by).with(user_uuid: 'parent_uuid').and_return(parent_user)
      allow(UserPersister).to receive(:create_from).and_return(new_user)
      allow(Country).to receive(:for).with('1').and_return('UK')
      allow(Emailer).to receive(:email_profile_to)
      allow(new_user).to receive(:save)
      allow(new_user).to receive(:add_parent)
      allow(parent_user).to receive(:add_child)
    end

    it 'creates the new user with details from the new user form' do
      expect(UserPersister).to receive(:create_from).with(name: 'user', country_id: '1', tale: 'story', email: 'email@example.com')
      post :create, user: user_details
    end

    it 'emails the user if an email address has been provided' do
      expect(Emailer).to receive(:email_profile_to).with('email@example.com')
      post :create, user: user_details
    end

    it 'does not try to email if no email address provided' do
      user_with_no_email = { name: 'user', country_id: '1', tale: 'story', parent_uuid: 'parent_uuid', email: 'email@example.com' }
      expect(Emailer).not_to receive(:email_profile_to)
      post :create, user: user_with_no_email
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
      allow(Story).to receive(:build_to_top_from).and_return('story up')
      allow(Story).to receive(:build_down_from).and_return('story down')
    end

    it 'finds the user to show' do
      expect(User).to receive(:find_by).with(user_uuid: 'uuid')
      get :show, user_uuid: 'uuid'
    end

    it 'builds the story to the top' do
      expect(Story).to receive(:build_to_top_from).with(user_uuid: 'uuid')
      get :show, user_uuid: 'uuid'
    end

    it 'builds the story from the user' do
      expect(Story).to receive(:build_down_from).with(user_uuid: 'uuid')
      get :show, user_uuid: 'uuid'
    end

    it 'creates a user display' do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: 'story up', future_story: 'story down')
      get :show, user_uuid: 'uuid'
    end

    context 'invalid users' do
      it 'throws an error if an invalid user is entered' do
        allow(User).to receive(:find_by).with(user_uuid: 'user_does_not_exist').and_return nil
        expect { get :show, user_uuid: 'user_does_not_exist' }.to raise_error UserException, 'The user you entered does not exist'
      end
    end
  end
end
