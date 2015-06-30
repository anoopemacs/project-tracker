require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(username: "test", password: "password") }

  describe ".find_by_credentials" do
    it "searches for user by username and password" do
      query = User.find_by_credentials("test", "password")
      expect(query.username).to eq subject.username
      expect(query.is_password?("password")).to be true
    end
  end

  describe "password to password_digest" do
    it "creates a valid password digest and doesn't store password" do
      expect(subject.password_digest).not_to eq "password"
    end

    it "can match stored passwords" do
      expect(subject.is_password?("password")).to be true
      expect(subject.is_password?("notPassword")).to be false
    end
  end

  describe "#reset_session_token!" do
    # original subject collides in database; create separate user to 
    # test reset_session_token (Validation failed: Username has already been taken)
    subject { User.create(username: "test123", password: "password")}

    it "creates new session token and saves" do 
      old_session_token = subject.session_token
      subject.reset_session_token!
      expect(subject.session_token).not_to eq old_session_token
    end
  end

  describe "#ensure_session_token" do 
    it "creates new session token on intiailize" do 
      expect(subject.session_token).not_to be_nil
    end

    it "detects presence of session token" do
      subject.session_token = "abcdef"
      subject.send(:ensure_session_token)
      expect(subject.session_token).to eq "abcdef"
    end
  end
end