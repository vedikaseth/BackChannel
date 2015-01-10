class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  belongs_to :post
  belongs_to :user

  #validates_presence_of :post_id
  #validates_presence_of :user_id
  #validates_uniqueness_of :post_id, :scope => :user_id

end
