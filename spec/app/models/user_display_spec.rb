require 'rails_helper'

describe UserDisplay do
  let(:parent_user)  { double(:parent_user, name: 'parent_username', user_uuid: 'parent_uuid') }
  let(:user_display) { UserDisplay.new(parent: parent_user, story: 'a long story', future_story: 'a future story') }

  describe 'parent_name' do
    it 'returns the users referral name' do
      expect(user_display.parent_name).to match(/parent_username/)
    end
  end

  describe 'parent_uuid' do
    it 'returns the users uuid' do
      expect(user_display.parent_uuid).to match(/parent_uuid/)
    end
  end

  describe 'story' do
    it 'returns the story' do
      expect(user_display.story).to match(/a long story/)
    end
  end

  describe 'future_story' do
    it 'returns the future story' do
      expect(user_display.future_story).to match(/a future story/)
    end
  end

  describe 'total_users' do
    before do
      allow(User).to receive(:all).and_return([{}, {}, {}])
    end

    it 'returns the total number of users' do
      expect(user_display.total_users).to be 3
    end
  end
end
