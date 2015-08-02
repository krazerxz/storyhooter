require 'rails_helper'

describe Story do
  describe '#build_from' do
    it 'returns a story of only one user' do
      user_1 = User.create!(tale: 'Beginning')
      story = Story.build_from(uuid: user_1.user_uuid)
      expect(story).to eq(['Beginning'])
    end

    it 'returns a story in the order it was created' do
      user_1 = User.create!(tale: 'Beginning')
      user_2 = User.create!(tale: 'Middle')
      user_3 = User.create!(tale: 'End')
      user_2.add_parent user_1
      user_3.add_parent user_2
      story = Story.build_from(uuid: user_3.user_uuid)
      expect(story).to eq(%w(Beginning Middle End))
    end
  end
end
