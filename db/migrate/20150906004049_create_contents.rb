class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :post_id
      t.timestamps
    end

    add_foreign_key :contents, :posts
  end
end
