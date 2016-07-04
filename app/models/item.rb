class Item < ActiveRecord::Base
  validates_presence_of :name, :room_id

  belongs_to :room
  belongs_to :user, through: :room

end