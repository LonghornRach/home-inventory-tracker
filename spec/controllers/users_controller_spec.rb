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
    it 'loads form for user to sign up' do
      visit '/signup'
      expect(page).to have_content(:form)
    end

    it 'creates a new user upon submission of form' do
      post '/signup', new_params
      expect(User.all.count).to eq(1)
    end

    it 'logs in new user and redirects to their home page' do
      post '/signup', new_params
      expect(last_response.location).to include('/users/test-user')
    end

    it 'does not load for already logged in user' do
      @user = User.create(new_params)
      post '/signup', new_params
      session = {}
      session[:id] = @user.id
      get '/signup'
      expect(last_response.location).to include('/users/test-user')
    end
  end

  describe "login page" do
    it 'has form for user to log in' do
      visit '/login'
      expect(page).to have_content(:form)
    end
    it 'logs in the user upon submission of form' do
      @user = User.create(new_params)
      post '/login', login_params
      expect(session[:id]).to eq(@user.id)
    end
    it 'redirects to users home page after login' do
      @user = User.create(new_params)
      post '/login', login_params
      expect(last_response.location).to include('/users/test-user')
    end
    it 'does not load for already logged in user' do
      @user = User.create(new_params)
      post '/login', login_params
      get '/login'
      expect(last_response.location).to include('/users/test-user')
    end
  end

end