require 'rails_helper'

describe Emailer do
  describe 'email_profile_to' do
    let(:user) { double(:user) }

    it 'sends a profile email' do
      Emailer.email_profile_to user
    end
  end
end
