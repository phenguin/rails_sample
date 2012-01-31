class Article < ActiveRecord::Base

  has_many :user_articles
  has_many :readers, :through => :user_articles, :source => :user

end
