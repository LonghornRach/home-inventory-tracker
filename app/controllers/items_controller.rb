class ItemsController < ApplicationController

  get '/items' do
    @user = current_user
    authorize!(@user)
    @rooms = @user.rooms.all
    erb :'/items/index'
  end

  get '/items/new' do
    @user = current_user
    authorize!(@user)
    erb :'/items/new'
  end

  post '/items' do
    @item = Item.new(params)
    if @item.save
      redirect '/items'
    else
      redirect '/items/new'
    end
  end

  get '/items/:id' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    erb :'/items/show'
  end

  get '/items/:id/edit' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    erb :'/items/edit'
  end

  patch '/items/:id' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    @item.update(params)
    redirect "/items/#{@item.id}"
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    @item.delete
    redirect '/items'
  end

end