require 'spec_helper'

describe Relationship do

  before(:each) do
    @follower = Factory(:user)
    @followed = Factory(:user, :email => Factory.next(:email))
    @relationship = @follower.relationships.build(:followed_id => @followed.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "Follow methods" do

    it "should respond to follower" do
      @relationship.should respond_to(:follower)
    end

    it "should respond to followed" do
      @relationship.should respond_to(:followed)
    end

    it "should have the right follower" do
      @relationship.follower.should == @follower
    end

    it "should have the right followed" do
      @relationship.followed.should == @followed
    end
  end
end
