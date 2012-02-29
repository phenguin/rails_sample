require 'spec_helper'

describe User do
  before(:each) do 
    @attr = { :name => "Test Fella", 
      :email => "fella@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"}
  end

  it 'should create a user given valid attributes' do 
    User.create!(@attr)
  end

  it 'should require a non-empty name' do 
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it 'should require a non-empty email address' do 
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it 'should reject names that are too long' do 
    long_name = 'a' * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it 'should accept valid email addresses' do 
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |addr|
      user = User.new(@attr.merge(:email => addr))
      user.should be_valid
    end
  end

  it 'should reject invalid email addresses' do 
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |addr|
      user = User.new(@attr.merge(:email => addr))
      user.should_not be_valid
    end
  end

  it 'should reject duplicate email addresses' do 
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it 'should reject duplicate email addresses insensitive to case' do 
    User.create!(@attr)
    upcase_email = @attr[:email].upcase
    user_with_duplicate_email = User.new(@attr.merge(:email => upcase_email))
    user_with_duplicate_email.should_not be_valid
  end

  describe 'password validations' do 

    it 'should require a non-empty password' do 
      User.new(@attr.merge(:password => "",:password_confirmation => "")).
        should_not be_valid
    end

    it 'should require matching password confirmation' do 
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it 'should reject too-short passwords' do 
      too_short_pass = 'a' * 5
      hash = @attr.merge(:password => too_short_pass,:password_confirmation => too_short_pass)
      User.new(hash).should_not be_valid
    end

    it 'should reject too-long passwords' do 
      too_long_pass = 'a' * 41
      hash = @attr.merge(:password => too_long_pass,:password_confirmation => too_long_pass)
      User.new(hash).should_not be_valid
    end

  end

  describe 'password encryption' do 

    before(:each) do 
      @user = User.create!(@attr)
    end

    it 'should have an encrypted password' do
      @user.should respond_to(:encrypted_password)
    end

    it 'should set a non-blank encrypted password' do
      @user.encrypted_password.should_not be_blank
    end

    describe 'has_password? method' do 

      it 'should be true if passwords match' do 
        @user.has_password?(@attr[:password]).should be_true
      end

      it 'should be false if passwords dont match' do 
        @user.has_password?('invalid').should be_false
      end
    end

    describe 'user authentication' do 

      it 'should return nil on email/pass mismatch' do 
        wrong_pass_user = User.authenticate(@attr[:email],'wrongpass')
        wrong_pass_user.should be_nil
      end

      it 'should return the user on email/pass match' do 
        correct_user = User.authenticate(@attr[:email],@attr[:password])
        correct_user.should == @user
      end

      it 'should return nil if no user is found with matching email' do 
        wrong_email_user = User.authenticate('nothere@nowhere.com',@attr[:password])
        wrong_email_user.should be_nil
      end
    end
  end

  describe 'admin attribute' do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe 'subscriptions' do

    before(:each) do
      @user = Factory(:user)
      @topic = Factory(:topic)
    end

    it "should respond to 'subscriptions'" do
      @user.should respond_to(:subscriptions)
    end

    it "should respond to 'subscribed_topics'" do
       @user.should respond_to(:subscribed_topics)     
    end

    it "should have a 'subscribe!' method" do
      @user.should respond_to(:subscribe!)
    end

    it "should respond to 'subscribed?'" do
       @user.should respond_to(:subscribed?)     
    end

    it "should subscribe to a topic" do
      @user.subscribe!(@topic)
      @user.should be_subscribed(@topic)
    end

    it "should include the topic in the users list of topics" do
      @user.subscribe!(@topic)
      @user.subscribed_topics.should include(@topic)
    end

  end

  describe 'user_articles' do

    before(:each) do
      @user = Factory(:user)
    end

    it "should respond to 'user_articles'" do
      @user.should respond_to(:user_articles)
    end

    it "should respond to 'bookmarks'" do
      @user.should respond_to(:bookmarks)
    end

  end

  describe "groups" do

    before(:each) do
      @user = Factory(:user)
      @group = Factory(:group)
    end

    it "should respond to 'affiliations'" do
      @user.should respond_to(:affiliations)
    end

    it "should respond to 'groups'" do
      @user.should respond_to(:groups)
    end

    it "should respond to 'group_join!'" do
      @user.should respond_to(:group_join!)
    end

    it "should respond to 'group_member?'" do
      @user.should respond_to(:group_member?)
    end

    it "should respond to 'group_leave!'" do
      @user.should respond_to(:group_leave!)
    end

    it "group_join! should add the user to the group" do
      @user.group_join!(@group)
      @user.should be_group_member(@group)
    end

    it "group should be included in users group list" do
      @user.group_join!(@group)
      @user.groups.should include(@group)
    end

    it "group_leave! should remove user from the group" do
      @user.group_join!(@group)
      @user.group_leave!(@group)
      @user.should_not be_group_member(@group)
    end

  end

  describe "relationships" do

    before(:each) do
      @user = Factory(:user)
      @followed = Factory(:user, :email => Factory.next(:email))
    end

    it "should respond to relationships" do
      @user.should respond_to(:relationships)
    end

    it "should respond to following" do
      @user.should respond_to(:following)
    end

    it "should have a follow! method" do
      @user.should respond_to(:follow!)
    end

    it "should have a following? method" do
      @user.should respond_to(:following?)
    end

    it "after follow!, user should be following?" do
      @user.follow!(@followed)
      @user.should be_following(@followed)
    end

    it "should be included in users following list" do
      @user.follow!(@followed)
      @user.following.should include(@followed)
    end

    it "should respond to unfollow!" do
      @user.should respond_to(:unfollow!)
    end

    it "should unfollow the user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      @user.should_not be_following(@followed)
    end

    it "should have a reverse_relationships method" do
      @user.should respond_to(:reverse_relationships)
    end

    it "should respond to followers" do
      @user.should respond_to(:followers)
    end

    it "should be included in the followers list" do
      @user.follow!(@followed)
      @followed.followers.should include(@user)
    end

  end

end
