require "rails_helper"

describe HomeController do
  describe "GET #index" do
    let(:user) { double(:user, user_uuid: 1) }

    before do
      allow(User).to receive_message_chain(:order, :limit, :first).and_return user
      allow(Story).to receive(:build_down_from).with(user_uuid: 1)
    end

    it "gets the first user" do
      expect(User).to receive_message_chain(:order, :limit, :first)
      get :index
    end

    it "builds story to the first user" do
      expect(Story).to receive(:build_down_from).with(user_uuid: 1)
      get :index
    end
  end
end
