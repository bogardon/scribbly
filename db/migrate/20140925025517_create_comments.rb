class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :post_id
      t.foreign_key :posts
      t.text :description
      t.timestamps
    end
  end
end
