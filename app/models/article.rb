class Article < ActiveRecord::Base

  def self.per_page
    8
  end

  scope :unread_by, (lambda do |user|
    joins(:user_articles).
      where(:user_articles => {:user_id => user.id}).
      where(:user_articles => {:read_date => nil} )
  end)

  has_many :user_articles
  has_many :readers, :through => :user_articles, :source => :user

end
