class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.text :description
      t.integer :collaboration_id
      t.foreign_key :collaborations, dependent: :delete
      t.timestamps
    end
  end
end
