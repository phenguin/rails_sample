require 'digest'

class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :subscriptions, :dependent => :destroy

  has_many :affiliations, :dependent => :destroy
  has_many :groups, :through => :affiliations

  has_many :user_articles, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  has_many :subscribed_topics, :through => :subscriptions, :source => :topic

  has_many :bookmarks, :through => :user_articles, :source => :article


  has_many :relationships, :foreign_key => :follower_id, :dependent => :destroy
  has_many :reverse_relationships, :foreign_key => :followed_id, 
    :class_name => "Relationship", :dependent => :destroy
  has_many :following, :through => :relationships,:source => :followed
  has_many :followers, :through => :reverse_relationships,:source => :follower

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
  
  #methods for dealing with following other users
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed.id).destroy
  end

  #methods for dealing with users/ articles
  def bookmark!(article)
    user_articles.create!( :article_id => article.id )
  end
  
  def bookmarked?(article)
    user_articles.find_by_article_id(article.id)
  end

  def mark_read!(article)
    article = user_articles.find_by_article_id(article.id)
    if article.read_date.nil?
      article.read_date = Time.now
      article.save!
    end
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

  def feed
    Article.with_topic_in(Topic.all)
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
