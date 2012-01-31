require 'digest'

class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :subscriptions
  has_many :affiliations
  has_many :user_articles
  has_many :posts
  has_many :subscribed_topics, :through => :subscriptions, :source => :topic
  has_many :bookmarks, :through => :subscriptions, :source => :article
  has_many :groups, :through => :affiliations

  validates :password, :presence => true,
    :confirmation => true,
    :length => { :within => 6..40 }

  validates :name, :presence => true,
    :length => { :maximum => 50 }

  validates :email, :presence => true,
    :format => { :with => email_regex },
    :uniqueness => { :case_sensitive => false }

  before_save :encrypt_password

  def self.authenticate(email,submitted_password)
    user = User.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  #methods for dealing with users / topics
  def subscribe!(topic)
    subscriptions.create!( :topic_id => topic.id )
  end

  def subscribed?(topic)
    subscriptions.find_by_topic_id(topic.id)
  end

  #methods for dealing with users / groups

  def group_join!(group)
    affiliations.create!( :group_id => group.id )
  end

  def group_member?(group)
    affiliations.find_by_group_id(group.id)
  end

  def group_leave!(group)
    affiliations.find_by_group_id(group.id).destroy
  end

  def has_password?(submitted)
    #Compare encrypted versions of submitted and
    #stored passwords
    return ( self.encrypted_password == encrypt(submitted) )
  end

  private

  def encrypt_password
    self.salt = make_salt unless has_password?(self.password)
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(string)
    secure_hash("#{self.salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{self.password}")
  end

  def secure_hash(string)
    #Wrapper for secure SHA2 hash function
    Digest::SHA2.hexdigest(string)
  end

end
