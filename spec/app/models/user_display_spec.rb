require 'rails_helper'

describe UserDisplay do
  describe 'referrer_name' do
    let(:parent_user)  { double(:parent_user, name: 'parent_username') }
    let(:user_display) { UserDisplay.new(parent: parent_user, story: 'a long story') }

    it 'returns the users referral name' do
      expect(user_display.referrer_name).to match(/parent_username/)
    end
  end
end
