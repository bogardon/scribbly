class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.datetime :scheduled_at
      t.integer :user_id
      t.integer :collaboration_id
      t.timestamps
    end
    add_foreign_key :posts, :users
    add_foreign_key :posts, :collaborations
  end
end
