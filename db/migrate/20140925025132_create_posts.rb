class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :campaign_id
      t.foreign_key :campaigns
      t.string :name
      t.datetime :scheduled_at
      t.timestamps
    end
  end
end
