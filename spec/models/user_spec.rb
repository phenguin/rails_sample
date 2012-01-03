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
end
