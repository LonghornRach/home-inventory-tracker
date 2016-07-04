require 'spec_helper'

params = {
  :name => "User Test",
  :email => "user@test.com",
  :password => "user_pass"
}

RSpec.describe User, type: :model do
  context "validations" do
    it 'is invalid without a name' do
      expect(User.create(name: nil, email: "user@test.com", password: "user_pass")).to_not be_valid
    end
    it 'is invalid without an email' do
      expect(User.create(name: "User Test", email: nil, password: "user_pass")).to_not be_valid
    end
    it 'is invalid without a password' do
      expect(User.create(name: "User Test", email: "user@test.com", password: nil)).to_not be_valid
    end
  end

  context "attributes" do

    before do
      @user = User.create(params)
    end

    it 'has a name' do
      expect(@user.name).to eq("User Test")
    end
    it 'has an email' do
      expect(@user.email).to eq("user@test.com")
    end
    it 'has a password' do
      expect(@user.password).to eq("user_pass")
    end
  end

  context "associations" do
    before do
      @user = User.create(params)

      @room1 = Room.create(name: "living")
      @room2 = Room.create(name: "kitchen")

      @item1 = Item.create(name: "table")
      @item2 = Item.create(name: "couch")
      @item3 = Item.create(name: "rug")

      @user.rooms << @room1
      @user.rooms << @room2

      @room1.items << @item2
      @room1.items << @item3
      @room2.items << @item1
    end

    it 'has many rooms' do
      expect(@user.rooms.count).to eq(2)
      expect(@user.rooms).to include(@room1)
    end
    it 'has many items through rooms' do
      user_items = []
      @user.rooms.each do |room|
        user_items << room.items
      end
      expect(user_items.flatten.count).to eq(3)
    end
  end

  context "methods" do
    before do
      @user = User.create(params)
    end

    it 'responds to authenticate method from has_secure_password' do
      expect(@user.authenticate("user_pass")).to be_truthy
    end
    it 'can slugify its name' do
      expect(@user.slug).to eq("user-test")
    end
    it 'given the slug can find the user' do
      expect((User.find_by_slug("user-test")).name).to eq("User Test")
    end
  end
end