require 'rails_helper'

describe Emailer do
  describe 'email_profile_to' do
    let(:mail_settings) do
      { to: 'user@example.com', from: 'storyhooter@example.com', subject: 'StoryHooter - Your profile link', via: :smtp,
        via_options: { address: 'smtp.gmail.com', port: '587', username: 'storyhooter@example.com', password: 'password',
                       authentication: :plain, enable_starttls_auto: true, domain: 'storyhooter.com' } }
    end

    it 'sends a profile email' do
      Emailer.email_profile_to 'user@example.com'
      expect(Pony).to receive(:mail=).with(mail_settings)
    end
  end
end
