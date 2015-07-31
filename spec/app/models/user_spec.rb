require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    xit 'validates uniqueness of uuid' do

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
