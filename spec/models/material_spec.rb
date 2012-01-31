require 'spec_helper'

describe Material do

  before(:each) do
    @material = Factory(:material)
  end

  it "should respond to week" do
    @material.should respond_to(:week)
  end

end
