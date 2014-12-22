class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.integer :collaboration_id
      t.text :description
      t.timestamps
    end
    add_foreign_key :campaigns, :collaborations
  end
end
