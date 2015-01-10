class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :postText
      t.references :category
      t.references :user
      t.timestamps
    end
  end
end
