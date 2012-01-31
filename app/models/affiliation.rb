class Affiliation < ActiveRecord::Base
  attr_accessible :group_id

  belongs_to :user
  belongs_to :group

  validates :group_id, :presence => true
  validates :user_id, :presence => true
end
