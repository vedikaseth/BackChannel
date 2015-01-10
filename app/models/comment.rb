class Comment < ActiveRecord::Base
  attr_accessible :commentText  , :user_id, :post_id
  belongs_to :user
  belongs_to :post
  has_many :comment_votes

  validates_presence_of :commentText
end
