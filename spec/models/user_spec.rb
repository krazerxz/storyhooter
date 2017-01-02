require "rails_helper"

RSpec.describe User, type: :model do
  describe "send_welcome_email" do
    let(:mailer) { double(:mailer) }

    subject { described_class.new(email: "'email@example.com") }

    before do
      allow(NewUserMailer).to receive(:new_user_email).with(subject).and_return mailer
    end

    it "sends an email to the user" do
      expect(mailer).to receive(:deliver_now)
      subject.send_welcome_email
    end

    context "no email address" do
      it "does not send an email" do
        subject.email = ""
        expect(mailer).not_to receive(:deliver_now)
        subject.send_welcome_email
      end
    end
  end

  describe "validations " do
    let(:user_1) { User.create }

    it "sets the email address to an empty string if none is provided" do
      expect(user_1.email).to eq ""
    end
  end

  describe "add_child" do
    let(:user_1) { User.create }
    let(:user_2) { User.new }

    it "adds a child user" do
      user_1.add_child user_2
      expect(user_1.children.count).to be 1
      expect(user_1.children.first.user_uuid).to eq user_2.user_uuid
    end
  end

  describe "add_parent" do
    let(:user_1) { User.create }
    let(:user_2) { User.new }

    it "adds a parent user" do
      user_1.add_parent user_2
      expect(user_1.parent.user_uuid).to eq user_2.user_uuid
    end
  end

  describe "profile_url" do
    it "returns the users unique profile url" do
      allow(SecureRandom).to receive(:hex).with(5).and_return("a_hex")
      user = User.create!
      expect(user.profile_url).to match(%r{/user/a_hex})
    end
  end
  describe "referral_url" do
    it "returns the users unique referral url" do
      allow(SecureRandom).to receive(:hex).with(5).and_return("a_hex")
      user = User.create!
      expect(user.referral_url).to match(%r{/user/new\?referred_from=a_hex})
    end
  end

  describe "#validations" do
    let(:user_1) { User.create! }

    it "assigns a random uuid on saving" do
      expect(user_1.user_uuid).to_not be nil
    end
  end

  describe "#save" do
    it "creates an random hex" do
      expect(SecureRandom).to receive(:hex).with(5)
      User.create
    end

    it "saves the user with the hex as the uuid" do
      allow(SecureRandom).to receive(:hex).with(5).and_return("a_hex")
      User.create(name: "a_user")
      user = User.find_by(name: "a_user")
      expect(user.user_uuid).to eq "a_hex"
    end
  end
end
