class CreateGroupTopics < ActiveRecord::Migration
  def change
    create_table :group_topics do |t|
      t.integer :group_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
