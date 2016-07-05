class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect_home(current_user)
    else
      erb :signup
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      # login!(@user)
      redirect_home(@user)
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      login!(user)
    else

    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/home'
  end
end