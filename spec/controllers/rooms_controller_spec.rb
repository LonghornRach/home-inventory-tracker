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

describe RoomsController do

  before do
    @user = User.create(user_params)

    @room1 = Room.create(name: "Living Room", notes: "has gas fireplace")
    @room2 = Room.create(name: "Kitchen")

    @item1 = Item.create(name: "table")
    @item2 = Item.create(name: "couch")
    @item3 = Item.create(name: "rug")

    @user.rooms << @room1
    @user.rooms << @room2

    @room1.items << @item2
    @room1.items << @item3
    @room2.items << @item1

    visit '/login'
    fill_in('name', with: "Test User")
    fill_in('password', with: "user_pass")
    click_on('submit')
  end

  describe "index" do
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
    before do
      visit '/rooms'
      click_on('Living Room')
    end
    it 'displays room details' do
      expect(page.text).to include ("has gas fireplace")
    end
    it 'lists rooms items as links' do
      click_on('couch')
      expect(current_path).to include("/items/")
    end
    it 'has option to edit room' do
      expect(page.text).to include("Edit Room Details")
    end
    it 'has link to add item' do
      expect(page.text).to include("Add New Item")
    end
  end

  describe "create" do
    before do
      visit '/rooms/new'
    end
    it 'shows form to create new room' do
      expect(page).to have_content(:form)
    end
    it 'saves and creates room and redirects to show page' do
      fill_in('name', with: 'Bedroom')
      fill_in('notes', with: 'upstairs')
      click_on('Create Room')
      expect(current_path).to include('/rooms')
      expect(page.text).to include("Bedroom")
    end
  end

  describe "edit" do
    before do
      visit '/rooms/living-room/edit'
    end
    it 'shows form with room details filled in' do
      expect(page).to have_content(:form)
      expect(find_field('name').value).to eq("Living Room")
    end
    it 'edits room and redirects to show page' do
      fill_in('name', with: "Living Area")
      click_on('Edit Room')

      expect(current_path).to include('/rooms/living-room')
      expect(page.text).to include("Living Area")
    end
  end

  describe "delete" do
    before do
      visit '/rooms/living-room/edit'
      click_on('Delete Room')
    end
    it 'deletes room and displays confirmation message' do
      expect(Room.all.count).to eq(1)
    end
    it 'redirects to room index' do
      expect(current_path).to include('/rooms')
    end
  end

  context "logged out" do
    before do
      visit '/logout'
    end

    it 'index page does not load' do
      visit '/rooms'
      expect(current_path).to include('/')
    end
    it 'show page does not load' do
      visit '/rooms/living-room'
      expect(current_path).to include('/')
    end
    it 'create page does not load' do
      visit '/rooms/new'
      expect(current_path).to include('/')
    end
    it 'edit page does not load' do
      visit '/rooms/living-room/edit'
      expect(current_path).to include('/')
    end
    it 'delete page does not load' do
      visit '/rooms/living-room/edit'
      expect(current_path).to include('/')
    end
  end
end