class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :body
      t.integer :post_id
      t.foreign_key :posts
      t.attachment :media
      t.timestamps
    end
  end
end
