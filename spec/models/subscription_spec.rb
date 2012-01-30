require 'spec_helper'

describe Subscription do

  before(:each) do
    @user = Factory(:user)
    @attr = { :topic_id => 1 }
    @subscription = @user.subscriptions.create(@attr)
  end

  it "should respond to user" do
    @subscription.should respond_to(:user)
  end

  it "should respond to topic" do
    @subscription.should respond_to(:topic)
  end

end
