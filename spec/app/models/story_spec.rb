require 'rails_helper'

describe Story do
  describe '#build_to_top_from' do
    it 'returns a story of only one user' do
      user_1 = User.create!(tale: 'Beginning', name: 'a', country_id: 1)
      story = Story.build_to_top_from(user_uuid: user_1.user_uuid)
      expect(story).to eq([{ 'tale': 'Beginning', 'name': 'a', 'country': 1 }])
    end

    it 'returns a story in the order it was created' do
      user_1 = User.create!(tale: 'Beginning', name: 'a', country_id: 1)
      user_2 = User.create!(tale: 'Middle', name: 'b', country_id: 2)
      user_3 = User.create!(tale: 'End', name: 'c', country_id: 3)
      user_2.add_parent user_1
      user_3.add_parent user_2
      story = Story.build_to_top_from(user_uuid: user_3.user_uuid)
      expect(story).to eq([
        { 'tale': 'Beginning', 'name': 'a', 'country': 1 },
        { 'tale': 'Middle', 'name': 'b', 'country': 2 },
        { 'tale': 'End', 'name': 'c', 'country': 3 }])
    end
  end

  describe '#build_down_from' do
    it 'returns a story when there is only one path' do
      user_1 = User.create!(tale: 'Beginning')
      user_2 = User.create!(tale: 'End')
      user_1.add_child user_2
      story = Story.build_down_from(user_uuid: user_1.user_uuid)
      expect(story).to eq(['End'])
    end

    it 'returns a story when there are multiple choices' do
      user_1 = User.create!(tale: 'Beginning')
      user_2 = User.create!(tale: 'Middle')
      user_3 = User.create!(tale: 'End')
      user_4 = User.create!(tale: 'Alternate-End')
      user_5 = User.create!(tale: 'Longer')
      user_1.add_child user_2
      user_2.add_child user_3
      user_2.add_child user_4
      user_4.add_child user_5
      story = Story.build_down_from(user_uuid: user_2.user_uuid)
      expect(true).to eq(story == %w(End) || story == %w(Alternate-End Longer))  # Going to regret this
    end
  end
end
