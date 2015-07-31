require 'rails_helper'

describe Story do
  describe '#build_from' do
    it '' do
      user_1 = User.create(tale: '1')
      user_2 = User.create(tale: '2', referral_user: user_1.uuid)
      user_3 = User.create(tale: '3', referral_user: user_2.uuid)
      story = Story.build_from(uuid: user_3.uuid)
      expect(story).to eq('1 2 3')
    end
  end
end
