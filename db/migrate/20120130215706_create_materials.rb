class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :week_id
      t.string :name
      t.string :description
      t.string :content

      t.timestamps
    end
    add_index :materials, :week_id
  end
end
