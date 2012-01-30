class Subscription < ActiveRecord::Base
  attr_accessible :topic_id
  validates :user_id, :presence => true
  validates :topic_id, :presence => true

  belongs_to :user
  belongs_to :topic
end
