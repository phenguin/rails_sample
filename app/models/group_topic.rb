class GroupTopic < ActiveRecord::Base
  attr_accessible :topic_id
  belongs_to :group
  belongs_to :topic
end
