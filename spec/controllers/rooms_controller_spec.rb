require 'spec_helper'

user_params = {
  :name => "Test User",
  :email => "user@test.com",
  :password => "user_pass"
}

login_params = {
  :name => "Test User",
  :password => "user_pass"
}

room_params = {
  :name => "Test Room"
}

describe RoomsController do

  before do
    @user = User.create(user_params)

    @room1 = Room.create(name: "Living Room")
    @room2 = Room.create(name: "Kitchen")

    @item1 = Item.create(name: "table")
    @item2 = Item.create(name: "couch")
    @item3 = Item.create(name: "rug")

    @user.rooms << @room1
    @user.rooms << @room2

    @room1.items << @item2
    @room1.items << @item3
    @room2.items << @item1

    # post '/login', login_params
  end

  describe "index" do
    before do
      visit '/login'
      fill_in('name', with: "Test User")
      fill_in('password', with: "user_pass")
      click_on('submit')
    end

    it 'displays all rooms' do
      visit '/rooms'
      expect(page.text).to include("Living Room")
      expect(page.text).to include("Kitchen")
    end

    it 'links to individual rooms' do
      visit '/rooms'
      click_on('Living Room')
      expect(current_path).to include('/rooms/living-room')
    end

    it 'has option to create new room' do
      visit '/rooms'
      expect(page.text).to include("Create New Room")
    end
  end

  describe "show" do
    it 'displays room details'
    it 'lists rooms items as links'
    it 'has option to edit room'
    it 'has link to add item'
    it 'only displays if user logged in'
  end

  describe "create" do
    it 'shows form to create new room'
    it 'saves and create room and redirects to show page'
    it 'has link to save and redirect to create new item'
    it 'only displays if user logged in'
  end

  describe "edit" do
    it 'shows form with room details filled in'
    it 'edits room and redirects to show page'
    it 'has option to delete room'
    it 'displays message of succssful edit'
    it 'only displays if user logged in'
  end

  describe "delete" do
    it 'deletes room and displays confirmation message'
    it 'redirects to room index'
  end

  context "logged out" do
    before do
      visit '/logout'
    end

    it 'index page does not load' do
      visit '/rooms'
      expect(current_path).to include('/')
    end
    it 'show page does not load'
    it 'create page does not load'
    it 'edit page does not load'
    it 'delete page does not load'
  end
end