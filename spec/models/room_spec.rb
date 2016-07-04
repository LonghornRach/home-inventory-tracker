require 'spec_helper'

RSpec.describe Room, type: :model do
  context "validations" do
    it 'is invalid without a name' do
      expect(Room.create(name: nil)).to_not be_valid
    end
  end

  context "attributes" do

    before do
      @room = Room.create(name: "kitchen")
    end
    it 'has a name' do
      expect(@room.name).to eq("kitchen")
    end
    it 'can have notes' do
      @room.notes = "includes dining area"
      expect(@room.notes.empty?).to be_falsey
    end
  end

  context "associations" do
    before do
      @user = User.create(name: "User Test", email: "user@test.com", password: "user_pass")
      @room = Room.create(name: "kitchen")

      @item1 = Item.create(name: "table")
      @item2 = Item.create(name: "stove")

      @user.rooms << @room

      @room.items << @item1
      @room.items << @item2

    end
    it 'belongs to user' do
      expect(@room.user).to eq(@user)
    end
    it 'has many items' do
      expect(@room.items.count).to eq(2)
    end
  end

  context "methods" do
    before do
      @room = Room.create(name: "living room")
    end
    it 'can slugify its name' do
      expect(@room.slug).to eq("living-room")
    end
    it 'given the slug can find the room' do
      expect(Room.find_by_slug("living-room")).to eq(@room)
    end
  end
end