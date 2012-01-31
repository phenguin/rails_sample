class Topic < ActiveRecord::Base

  has_many :subscriptions
  has_many :group_topics
  has_many :subscribed_users, :through => :subscriptions, :source => :user
  has_many :groups, :through => :group_topics

end
