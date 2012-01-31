class Group < ActiveRecord::Base
  attr_accessible :name, :creator_id
  #belongs_to :creator, :class => "User"

  validates :name, :presence => true

  has_many :affiliations
  has_many :group_topics
  has_many :weeks
  has_many :users, :through => :affiliations
  has_many :topics, :through => :group_topics

  def user_is_admin?(user)
    if user.group_member?(self)
      affiliations.find_by_user_id(user.id).admin
    else
      nil
    end
  end

  def topic_add!(topic)
    group_topics.create!(:topic_id => topic.id )
  end

  def topic_remove!(topic)
    group_topics.find_by_id(topic.id).destroy
  end

  def topic_member?(topic)
    group_topics.find_by_id(topic.id)
  end

end
