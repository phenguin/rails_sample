class AddAdminToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :admin, :boolean, :default => false
  end
end
