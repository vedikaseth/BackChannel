class Tag < ActiveRecord::Base
  attr_accessible :tagText, :post_id
  belongs_to :post
end
