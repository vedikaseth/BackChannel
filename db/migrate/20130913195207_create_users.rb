class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userName
      t.string :fname
      t.string :lname
      t.string :userType
      t.string :password

      t.timestamps
    end
  end
end
