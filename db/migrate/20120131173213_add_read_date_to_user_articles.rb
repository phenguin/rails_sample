class AddReadDateToUserArticles < ActiveRecord::Migration
  def change
    add_column :user_articles, :read_date, :datetime
    add_index :user_articles, :read_date
  end
end
