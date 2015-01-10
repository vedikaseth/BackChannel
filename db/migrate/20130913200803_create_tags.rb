class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tagText
      t.references :post
      t.timestamps
    end
  end
end
