class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
    add_index :affiliations, [:user_id, :group_id], :unique => true
  end
end
