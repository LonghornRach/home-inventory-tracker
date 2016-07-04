require 'spec_helper'

new_params = {
  :name => "Test User",
  :email => "user@test.com",
  :password => "user_pass"
}

login_params = {
  :name => "Test User",
  :password => "user_pass"
}

describe ApplicationController do
  describe "index page" do
    it 'welcomes viewers' do
      visit '/'
      expect(page.text).to include("Welcome")
    end
    it 'links to signup page' do
      visit '/'
      expect(find_all(:link).first.text).to eq("Sign Up!")
    end
    it 'links to login page' do
      visit '/'
      expect(find_all(:link).last.text).to eq("Log In")
    end
  end

  describe "login page" do
    it 'has form for user to log in'
    it 'logs in the user upon submission of form'
    it 'redirects to users home page after login'
    it 'does not load for already logged in user'
  end

  describe "signup page" do
    it 'loads form for user to sign up'
    it 'creates a new user upon submission of form'
    it 'logs in new user and redirects to their home page'
    it 'does not load for already logged in user'
  end
end