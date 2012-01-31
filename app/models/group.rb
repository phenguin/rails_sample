class Group < ActiveRecord::Base
  attr_accessible :name, :creator_id
  #belongs_to :creator, :class => "User"
  has_many :affiliations
  has_many :weeks
  has_many :users, :through => :affiliations
end
