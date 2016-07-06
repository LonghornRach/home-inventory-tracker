class RoomsController < ApplicationController

  get '/rooms' do
    @user = current_user
    authorize!(@user)
    @rooms = @user.rooms.all
    erb :'/rooms/index'
  end

  get '/rooms/new' do
    @user = current_user
    authorize!(@user)
    erb :'/rooms/new'
  end

  post '/rooms' do
    @room = Room.new(params)
    if @room.save
      current_user.rooms << @room
      redirect '/rooms'
    else
      redirect '/rooms/new'
      # flash - invalid entry
    end
  end

  get '/rooms/:slug' do
    @room = Room.find_by_slug(params[:slug])
    @owner = User.find_by_id(@room.user_id)
    authorize!(@owner)
    erb :'/rooms/show'
  end

  get '/rooms/:slug/edit' do
    @room = Room.find_by_slug(params[:slug])
    @owner = User.find_by_id(@room.user_id)
    authorize!(@owner)
    erb :'/rooms/edit'
  end

  patch '/rooms/:slug' do
    @room = Room.find_by_slug(params[:slug])
    @owner = User.find_by_id(@room.user_id)
    authorize!(@owner)
    @room.update(:name => params[:name], :notes => params[:notes])
    #flash - update successful
    redirect "/rooms/#{@room.slug}"
  end

  delete '/rooms/:slug/delete' do
    @room = Room.find_by_slug(params[:slug])
    @owner = User.find_by_id(@room.user_id)
    authorize!(@owner)
    @room.items.delete_all
    @room.delete
    # flash - delete successful
    redirect '/rooms'
  end

end