require 'spec_helper'

describe ItemsController do
  before do
    @user = User.create(:name => "Test User", :email => "user@test.com", :password => "user_pass")

    @room1 = Room.create(:name => "Living Room", :notes => "has gas fireplace")
    @room2 = Room.create(:name => "Kitchen")

    @item1 = Item.create(:name => "table", :notes => "reclaimed wood")
    @item2 = Item.create(:name => "couch")
    @item3 = Item.create(:name => "rug")

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

    before do
      visit '/items'
    end
    it 'displays all items sorted by room' do
      expect(page.text).to include("table")
      expect(page.text).to include("Kitchen")
    end

    it 'links to individual items' do
      click_on('table')
      expect(page.text).to include("Notes:")
    end

    it 'has option to create new item' do
      expect(page.text).to include("Create New Item")
    end
  end

  describe "show" do
    before do
      visit '/items'
      click_on('table')
    end
    it 'displays item details' do
      expect(page.text).to include ("reclaimed wood")
    end
    it 'has option to edit item' do
      expect(page.text).to include("Edit Item Details")
    end
    it 'has link to delete item' do
      expect(page.text).to include("Delete Item")
    end
  end

  describe "create" do
    before do
      visit '/items/new'
    end
    it 'shows form to create new item' do
      expect(page).to have_content(:form)
    end
    it 'saves and creates item and redirects to show page' do
      fill_in('name', with: 'chair')
      choose('Living Room')
      click_on('Create Item')
      expect(current_path).to include('/items')
      expect(page.text).to include("chair")
    end
  end

  describe "edit" do
    before do
      visit '/items/table/edit'
    end
    it 'shows form with item details filled in' do
      expect(page).to have_content(:form)
      binding.pry
      expect(find_field('name').value).to eq("table")
      expect(find_field('Kitchen')).to be_checked
    end
    it 'edits item and redirects to show page' do
      fill_in('name', with: "dining table")
      click_on('Edit Room')

      expect(page.text).to include("dining table")
    end
  end

  # describe "delete" do
  #   before do
  #     visit '/rooms/living-room/edit'
  #     click_on('Delete Room')
  #   end
  #   it 'deletes item' do
  #     expect(Room.all.count).to eq(1)
  #   end
  #   it 'redirects to item index' do
  #     expect(current_path).to include('/rooms')
  #   end
  # end

  # context "logged out" do
  #   before do
  #     visit '/logout'
  #   end

  #   it 'index page does not load' do
  #     visit '/rooms'
  #     expect(current_path).to include('/')
  #   end
  #   it 'show page does not load' do
  #     visit '/rooms/living-room'
  #     expect(current_path).to include('/')
  #   end
  #   it 'create page does not load' do
  #     visit '/rooms/new'
  #     expect(current_path).to include('/')
  #   end
  #   it 'edit page does not load' do
  #     visit '/rooms/living-room/edit'
  #     expect(current_path).to include('/')
  #   end
  #   it 'delete page does not load' do
  #     visit '/rooms/living-room/edit'
  #     expect(current_path).to include('/')
  #   end
  # end
end