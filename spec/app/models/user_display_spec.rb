require 'rails_helper'

describe UserDisplay do
  let(:parent_user)  { double(:parent_user, name: 'parent_username', uuid: 'parent_uuid') }
  let(:user_display) { UserDisplay.new(parent: parent_user, story: 'a long story') }

  describe 'referrer_name' do
    it 'returns the users referral name' do
      expect(user_display.referrer_name).to match(/parent_username/)
    end
  end

  describe 'referrer_uuid' do
    it 'returns the users uuid' do
      expect(user_display.referrer_uuid).to match(/parent_uuid/)
    end
  end

  describe 'story' do
    it 'returns the story' do
      expect(user_display.story).to match(/a long story/)
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
