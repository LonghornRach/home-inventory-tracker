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
      # binding.pry
      choose('Living Room')
      # binding.pry
      click_on('Create Item')
      expect(current_path).to include('/items')
      expect(page.text).to include("chair")
    end
  end

  describe "edit" do
    before do
      visit '/items'
      click_on('table')
      click_on('Edit Item Details')
    end
    it 'shows form with item details filled in' do
      expect(page).to have_content(:form)
      # binding.pry
      expect(find_field('name').value).to eq("table")
    end
    it 'edits item details' do
      fill_in('name', with: "dining table")
      click_on('Edit Item')
      expect(page.text).to include("dining table")
    end
    it 'edits item location' do
      # binding.pry
      choose('Living Room')
      click_on('Edit Item')
      # binding.pry
      expect(page.text).to include("Location: Living Room")
    end
  end

  describe "delete" do
    before do
      visit '/items'
      click_on('table')
      click_on('Delete Item')
    end
    it 'deletes item' do
      expect(Item.all.count).to eq(2)
    end
    it 'redirects to item index' do
      expect(current_path).to include('/items')
    end
  end

  context "logged out" do
    before do
      visit '/logout'
    end

    it 'index page does not load' do
      visit '/items'
      expect(current_path).to include('/')
    end
    it 'show page does not load' do
      visit "/items/#{@item2.id}"
      expect(current_path).to include('/')
    end
    it 'create page does not load' do
      visit '/items/new'
      expect(current_path).to include('/')
    end
    it 'edit page does not load' do
      visit "/items/#{@item2.id}/edit"
      expect(current_path).to include('/')
    end
  end
end