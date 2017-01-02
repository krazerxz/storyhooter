require "rails_helper"

describe UsersController, type: :controller do
  describe "Get /users/new?referred_from=:user_uuid" do
    let(:parent_user) { double(:parent_user) }
    let(:story)       { double(:story) }

    before do
      allow(User).to receive(:find_by).with(user_uuid: "a_hex_code").and_return(parent_user)
      allow(Story).to receive(:build_to_top_from).with(user_uuid: "a_hex_code").and_return(story)
      allow(UserDisplay).to receive(:new).and_return("user_display")
    end

    it "finds the referring user" do
      expect(User).to receive(:find_by).with(user_uuid: "a_hex_code")
      get :new, referred_from: "a_hex_code"
    end

    it "builds the story from the referring user" do
      expect(Story).to receive(:build_to_top_from).with(user_uuid: "a_hex_code")
      get :new, referred_from: "a_hex_code"
    end

    it "creates a user display" do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: story)
      get :new, referred_from: "a_hex_code"
    end

    context "invalid users" do
      it "throws an error if an invalid user is entered" do
        allow(User).to receive(:find_by).with(user_uuid: "user_does_not_exist").and_return nil
        expect { get :new, referred_from: "user_does_not_exist" }.to raise_error UserException, "The referrer you entered does not exist"
      end

      it "throws an error if no user is entered" do
        allow(User).to receive(:find_by).with(user_uuid: nil).and_return nil
        expect { get :new }.to raise_error UserException, "The referrer you entered does not exist"
      end
    end
  end

  describe "Post /users/create" do
    let(:user_details)   { {name: "user", country_id: "1", tale: "story", parent_uuid: "parent_uuid", email: "email@example.com"} }
    let(:new_user)       { double(:new_user, user_uuid: 1, email: user_details[:email]) }
    let(:user_mailer)    { double(:user_mailer).as_null_object }
    let(:user_persister) { double(:user_persister) }

    before do
      allow(UserPersister).to receive(:new).with(user_details).and_return user_persister
      allow(user_persister).to receive(:create).and_return(new_user)
      allow(new_user).to receive(:save).and_return true
      allow(new_user).to receive :send_welcome_email
      allow(NewUserMailer).to receive(:new_user_email).and_return user_mailer
    end

    it "creates the new user with details from the new user form" do
      expect(user_persister).to receive(:create)
      post :create, user: user_details
    end

    it "sends an email to the new user" do
      expect(new_user).to receive(:send_welcome_email)
      post :create, user: user_details
    end

    it "redirects to the users page" do
      post :create, user: user_details
      expect(response).to redirect_to(user_url(user_uuid: 1))
    end
  end

  describe "get /users/show" do
    let(:parent_user) { double(:parent_user) }
    let(:current_user) { double(:current_user, user_uuid: "uuid", parent: parent_user) }

    before do
      allow(User).to receive(:find_by).with(user_uuid: "uuid").and_return(current_user)
      allow(Story).to receive(:build_to_top_from).and_return("story up")
      allow(Story).to receive(:build_down_from).and_return("story down")
    end

    it "finds the user to show" do
      expect(User).to receive(:find_by).with(user_uuid: "uuid")
      get :show, user_uuid: "uuid"
    end

    it "builds the story to the top" do
      expect(Story).to receive(:build_to_top_from).with(user_uuid: "uuid")
      get :show, user_uuid: "uuid"
    end

    it "builds the story from the user" do
      expect(Story).to receive(:build_down_from).with(user_uuid: "uuid")
      get :show, user_uuid: "uuid"
    end

    it "creates a user display" do
      expect(UserDisplay).to receive(:new).with(parent: parent_user, story: "story up", future_story: "story down")
      get :show, user_uuid: "uuid"
    end

    context "invalid users" do
      it "throws an error if an invalid user is entered" do
        allow(User).to receive(:find_by).with(user_uuid: "user_does_not_exist").and_return nil
        expect { get :show, user_uuid: "user_does_not_exist" }.to raise_error UserException, "The user you entered does not exist"
      end
    end
  end
end
