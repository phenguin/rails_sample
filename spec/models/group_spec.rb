require 'spec_helper'

describe Group do

  describe "users" do

    before(:each) do
      @group = Factory(:group)
      @user1 = Factory(:user)
      @user2 = Factory(:user, :email => Factory.next(:email))
      @users = [@user1, @user2]
    end

    it "should respond to 'users'" do
      @group.should respond_to(:users)
    end

  end

end
