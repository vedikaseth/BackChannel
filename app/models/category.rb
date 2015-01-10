class Category < ActiveRecord::Base
  attr_accessible :categoryName
  has_many :posts
  validates_presence_of :categoryName
  validates_uniqueness_of :categoryName
end
