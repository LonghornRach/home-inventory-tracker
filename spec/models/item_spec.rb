require 'spec_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it 'is invalid without a name' do
      expect(Item.create(name: nil)).to_not be_valid
    end
  end

  context "attributes" do

    before do
      @item = Item.create(name: "couch")

      @room = Room.create(name: "living")
    end
    it 'has a name' do
      expect(@item.name).to eq("couch")
    end
    it 'has a room' do
      @item.room = @room
      expect(@item.room.name).to eq("living")
    end
    it 'can have notes' do
      @item.notes = "dingy"
      expect(@item.notes.empty?).to be_falsey
    end
  end

  context "associations" do

    before do
      @item = Item.create(name: "couch")

      @room = Room.create(name: "living")

      @user = User.create(name: "User Test", email: "user@test.com", password: "user_pass")
      @user.rooms << @room

      @room.items << @item

    end

    it 'belongs to 1 room' do
      expect(@item.room).to eq(@room)
    end
    it 'has 1 user through room' do
      expect(@item.room.user).to eq(@user)
    end
  end
end