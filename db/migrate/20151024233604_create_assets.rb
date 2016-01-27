class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :post_id
      t.timestamps
    end
    add_foreign_key :assets, :posts
  end
end
