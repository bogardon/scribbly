class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :collaboration_id
      t.timestamps
    end
    add_foreign_key :memberships, :users
    add_foreign_key :memberships, :collaborations
  end
end
