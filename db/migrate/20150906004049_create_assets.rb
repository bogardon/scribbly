class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.column :type, :integer, default: 0
      t.datetime :approved_at
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end

    add_foreign_key :assets, :users
    add_foreign_key :assets, :posts
  end
end
