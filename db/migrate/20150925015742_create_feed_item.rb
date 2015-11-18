class CreateFeedItem < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :type
      t.string :body
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end
    add_foreign_key :feed_items, :users
    add_foreign_key :feed_items, :posts
  end
end
