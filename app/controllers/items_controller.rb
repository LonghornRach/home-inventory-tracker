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
    @item = Item.new(:name => params[:name], :notes => params[:notes])
    @item.room = Room.find_by_slug(params[:room])
    if @item.save
      flash[:message] = "Item created successfully."
      redirect '/items'
    else
      redirect '/items/new'
    end
  end

  get '/items/:id' do
    @item = Item.find_by_id(params[:id])
    if @item != nil
      @owner = @item.room.user
      authorize!(@owner)
      erb :'/items/show'
    else
      redirect '/items'
    end
  end

  get '/items/:id/edit' do
    @item = Item.find_by_id(params[:id])
    if @item != nil
      @owner = @item.room.user
      authorize!(@owner)
      erb :'/items/edit'
    else
      redirect '/items'
    end
  end

  patch '/items/:id' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    @item.update(:name => params[:name], :notes => params[:notes])
    @item.room = Room.find_by_slug(params[:room])
    @item.save
    flash[:message] = "Sucessfully updated item."
    redirect "/items/#{@item.id}"
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    @owner = @item.room.user
    authorize!(@owner)
    @item.delete
    flash[:message] = "Item deleted."
    redirect '/items'
  end

end