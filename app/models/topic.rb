class Topic < ActiveRecord::Base
  has_many :subscriptions
end