class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :post_id, :user_id

  belongs_to :comment
  belongs_to :post
  belongs_to :user

  #validates_presence_of :comment_id
  #validates_presence_of :user_id
  #validates_uniqueness_of :comment_id, :scope => :user_id

end
