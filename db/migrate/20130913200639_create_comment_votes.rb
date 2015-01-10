class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.references :comment
      t.references :post
      t.references :user
      t.timestamps
    end
  end
end
