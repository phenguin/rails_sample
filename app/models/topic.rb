class Topic < ActiveRecord::Base

  has_many :subscriptions
  has_many :subscribed_users, :through => :subscriptions, :source => :user

end
