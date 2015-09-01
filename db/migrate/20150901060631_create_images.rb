class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :attachment
      t.references :imageable, polymorphic: true, index: true
    end
  end
end
