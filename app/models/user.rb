require_relative "../helpers/slugifier"

class User < ActiveRecord::Base
  include Slugifier

  has_secure_password
  validates_presence_of :name, :email, :password

  has_many :rooms
  has_many :items, through: :rooms

end