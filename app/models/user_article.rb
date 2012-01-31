class UserArticle < ActiveRecord::Base
  attr_accessible :article_id, :read_date

  validates :user_id, :presence => true
  validates :article_id, :presence => true

  belongs_to :user
  belongs_to :article
end
