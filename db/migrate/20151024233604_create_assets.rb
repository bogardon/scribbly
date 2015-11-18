class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :type
      t.string :body
      t.integer :content_id
      t.timestamps
    end
    add_foreign_key :assets, :contents
  end
end
