require 'spec_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it 'is invalid without a name'
  end

  context "attributes" do
    it 'has a name'
    it 'has a room'
    it 'can have notes'
  end

  context "associations" do
    it 'belongs to 1 room'
    it 'has 1 user through room'
  end
end