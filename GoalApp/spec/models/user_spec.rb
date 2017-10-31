require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  subject(:user) do
    FactoryBot.build(:user,
      username: "jfake",
      email: "jonathan@fakesite.com",
      password: "good_password")
  end


  describe "User validations" do
    it { should validate_presence_of(:username) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password_digest) }

    it { should validate_presence_of(:session_token) }

    it { should validate_length_of(:password).is_at_least(7) }

    it "creates a password digest when a password is given" do
      expect(user.password_digest).not_to be_nil
    end

    it "creates a session token" do
      expect(user.session_token).not_to be_nil
    end
  end

  # describe "User associations" do
  #   it { should have_many(:goals) }
  #
  #   it { should have_many(:comments) }
  #
  #
  # end

  describe ".find_by_credentials" do
    before { user.save! }

    it "returns user given good credentials" do
      expect(User.find_by_credentials("jfake", "good_password")).to eq(user)
    end

    it "returns nil given bad credentials" do
      expect(User.find_by_credentials("jfake", "bood_password")).to eq(nil)
    end

  end

  describe "#reset_session_token!" do
    it "sets a new session token on the user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?("good_password")).to be true
    end

    it "verifies a password is not correct" do
      expect(user.is_password("bad_password")).to be false
    end
  end


end
