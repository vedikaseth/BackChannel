class User < ActiveRecord::Base
  attr_accessible :fname, :lname, :password, :userName, :userType
  has_many :posts
  has_many :comments
  has_many :post_votes
  has_many :comment_votes

  validates_uniqueness_of :userName
  validates_presence_of :userName
  validates_presence_of :userType
  validates_presence_of :fname
  validates_presence_of :lname
  validates_presence_of :password

 def self.authenticate(userName, password)

 user = self.find_by_userName(userName)

   if user
     if user.password != password
      user = nil
     end

   end
     user
 end


end
