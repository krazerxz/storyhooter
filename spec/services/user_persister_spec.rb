require 'rails_helper'

describe UserPersister do
  describe 'create_from' do
    let(:user_hash) { { name: 'user', country: 'lala land', tale: 'story' } }

    it 'resolves the country id to a country' do
      expect(Country).to receive(:for).with(1)
      UserPersister.create_from(name: 'user', country_id: '1', tale: 'story')
    end

    it 'saves a user' do
      allow(Country).to receive(:for).with(1).and_return('lala land')
      expect(User).to receive(:create).with(user_hash)
      UserPersister.create_from(name: 'user', country_id: '1', tale: 'story')
    end
  end
end
