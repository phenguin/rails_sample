class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  validates :password, :presence => true,
    :confirmation => true,
    :length => { :within => 6..40 }

  validates :name, :presence => true,
    :length => { :maximum => 50 }

  validates :email, :presence => true,
    :format => { :with => email_regex },
    :uniqueness => { :case_sensitive => false }
end
