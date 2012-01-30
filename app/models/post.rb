class Post < ActiveRecord::Base
  belongs_to :week
  belongs_to :user

  validates :week_id, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true
end
