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

describe UsersController do
  describe "signup page" do
    it 'loads form for user to sign up'
    it 'creates a new user upon submission of form'
    it 'logs in new user and redirects to their home page'
    it 'does not load for already logged in user'
  end

  describe "login page" do
    it 'has form for user to log in' do
      visit '/login'
      expect(page).to have_content(:form)
    end
    it 'logs in the user upon submission of form' do
      @user = User.create(new_params)

      visit '/login'
      # binding.pry
      fill_in('name', with: @user.name)
      fill_in('password', with: @user.password)
      click_on('submit')
      # click_on(:input[type="submit"])

      binding.pry
    end
    it 'redirects to users home page after login'
    it 'does not load for already logged in user'
  end

end