require_relative "../helpers/slugifier"

class Room < ActiveRecord::Base
  include Slugifier

  validates_presence_of :name

  has_many :items
  belongs_to :user

end