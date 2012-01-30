require 'spec_helper'

describe Topic do

  before(:each) do
    @attr =  {
      :name =>  "Science",
      :description => "Learn about sciency stuff"
    }
  end

  it  'should create a topic given valid attributes' do
    Topic.create!(@attr)
  end

  it 'should require a non-empty name' do
    User.new(@attr.merge(:name => "")).should_not be_valid
  end

  describe 'subscriptions' do

    before(:each) do
      @topic = Factory(:topic)
    end

    it "should respond to 'subscribed_users'" do
      @topic.should respond_to(:subscribed_users)
    end

  end

end
