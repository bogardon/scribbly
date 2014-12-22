class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :body
      t.attachment :media
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end
    add_foreign_key :contents, :users
    add_foreign_key :contents, :posts
  end
end
