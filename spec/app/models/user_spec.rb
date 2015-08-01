require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'referral_url' do
    it 'returns the users unique referral url' do
      allow(SecureRandom).to receive(:hex).with(5).and_return('a_hex')
      user = User.create!
      expect(user.referral_url).to match(%r{/user/new\?referred_from=a_hex})
    end
  end

  describe '#validations' do
    xit 'does not save a user if one already exists with the same uuid' do
      User.create!(uuid: '1')
      User.create!(uuid: '1')
      expect(User.all.count).to be 1
    end
  end

  describe '#save' do
    it 'creates an random hex' do
      expect(SecureRandom).to receive(:hex).with(5)
      User.create
    end

    it 'saves the user with the hex as the uuid' do
      allow(SecureRandom).to receive(:hex).with(5).and_return('a_hex')
      User.create(name: 'a_user')
      user = User.find_by(name: 'a_user')
      expect(user.uuid).to eq 'a_hex'
    end
  end
end
