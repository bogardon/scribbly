class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
  end
end
