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
      # binding.pry
      expect(last_response.location).to include('/users/test-user')
    end
  end

  # describe "login page" do
  #   it 'has form for user to log in' do
  #     visit '/login'
  #     expect(page).to have_content(:form)
  #   end
  #   it 'logs in the user upon submission of form' do
  #     @user = User.create(new_params)

  #     visit '/login'
  #     # binding.pry
  #     fill_in('name', with: @user.name)
  #     fill_in('password', with: @user.password)
  #     click_on('submit')
  #     # click_on(:input[type="submit"])

  #     binding.pry
  #   end
  #   it 'redirects to users home page after login'
  #   it 'does not load for already logged in user'
  # end

end