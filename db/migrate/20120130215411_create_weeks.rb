class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :group_id
      t.integer :week_number

      t.timestamps
    end

    add_index :weeks, [:group_id, :week_number], :unique => true
  end
end
