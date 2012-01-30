class Week < ActiveRecord::Base
  belongs_to :group
  has_many :posts
  has_many :materials

  validates :group_id, :presence => true
  validates :week_number, :presence => true

end
