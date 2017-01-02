require "rails_helper"

describe UserPersister do
  let(:user_params)     { {name: "user", country_id: "1", tale: "story", parent_uuid: "parent_uuid", email: "email@example.com"} }
  let(:user_attributes) { {name: user_params[:name], country: country, tale: user_params[:tale], email: user_params[:email]} }

  subject { described_class.new(user_params) }

  describe "create" do
    let(:user)    { double(:user) }
    let(:parent)  { double(:parent) }
    let(:country) { "lala land" }

    before do
      allow(User).to receive(:create).with(user_attributes).and_return user
      allow(Country).to receive(:for).with(1).and_return country
      allow(User).to receive(:find_by).with(user_uuid: user_params[:parent_uuid]).and_return parent
      allow(user).to receive(:add_parent)
      allow(parent).to receive(:add_child)
    end

    it "creates the new user" do
      expect(User).to receive(:create).with user_attributes
      subject.create
    end

    it "adds the parent to the new user" do
      expect(user).to receive(:add_parent).with parent
      subject.create
    end

    it "adds the new user as a child to the parent" do
      expect(parent).to receive(:add_child).with user
      subject.create
    end

    it "returns the user" do
      expect(subject.create).to eq user
    end
  end
end
