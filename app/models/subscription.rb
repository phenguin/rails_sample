class Subscription < ActiveRecord::Base
  attr_accessor :topic_id
  validates :user_id, :presence => true
  validates :topic_id, :presence => true

  belongs_to :user
  belongs_to :topic
end
