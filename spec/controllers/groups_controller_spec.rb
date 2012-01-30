require 'spec_helper'

describe GroupsController do

  before(:each) do
    @group = Factory(:group)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @group
      response.should be_success
    end
  end

end
