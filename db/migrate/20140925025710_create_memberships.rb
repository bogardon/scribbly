class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :collaboration_id
      t.foreign_key :collaborations
      t.timestamps
    end
  end
end
