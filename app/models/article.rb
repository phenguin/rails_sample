class Article < ActiveRecord::Base

  has_many :user_articles
  has_many :users_reading, :through => :user_articles, :source => :user

end
