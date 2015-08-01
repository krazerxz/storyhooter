require 'rails_helper'

describe Story do
  describe '#build_from' do
    it 'returns a story of only one user' do
      user_1 = User.create!(tale: 'Beginning')
      story = Story.build_from(uuid: user_1.uuid)
      expect(story).to eq(['Beginning'])
    end

    it 'returns a story in the order it was created' do
      user_1 = User.create!(tale: 'Beginning')
      user_2 = User.create!(tale: 'Middle', referrer_id: user_1.id)
      user_3 = User.create!(tale: 'End', referrer_id: user_2.id)
      story = Story.build_from(uuid: user_3.uuid)
      expect(story).to eq(%w(Beginning Middle End))
    end
  end
end
