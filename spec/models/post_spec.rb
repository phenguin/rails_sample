require 'spec_helper'

describe Post do

  before(:each) do
    @post = Factory(:post)
  end

  it "should respond to 'week'" do
    @post.should respond_to(:week)
  end

  it "should respond to 'user'" do
    @post.should respond_to(:user)
  end

end
