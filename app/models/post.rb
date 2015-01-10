class Post < ActiveRecord::Base
  attr_accessible :postText , :category_id, :user_id
  belongs_to :category
  belongs_to :user
  has_many :post_votes
  has_many :tags

  validates_presence_of :postText
end
