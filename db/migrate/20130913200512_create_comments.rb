class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :commentText
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
