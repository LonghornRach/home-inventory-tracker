class UsersController < ApplicationController

  get '/signup' do

  end

  post '/signup' do

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
end