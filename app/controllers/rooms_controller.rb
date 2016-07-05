class RoomsController < ApplicationController

  get '/rooms' do
    @user = current_user
    authorize!(@user)
    erb :'/rooms/index'
  end

  get '/rooms/new' do
    erb :'/rooms/new'
  end

  post '/rooms' do

  end

  get '/rooms/:slug' do
    @room = Room.find_by_slug(params[:slug])
    erb :'/rooms/show'
  end

  get '/rooms/:slug/edit' do
    erb :'/rooms/edit'
  end

  patch '/rooms/:slug' do

  end

  delete '/rooms/:slug/delete' do

  end

end