require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    describe "when not signed in" do
      before(:each) do
        get :home
      end

      it "returns http success" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title",
                                      :content => "Sample App | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(other_user)
      end

      it "should have the right follower/following counts" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                      :content => "1 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                      :content => "0 follower")
      end
      
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => "Sample App | Contact")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => "Sample App | About")
    end
  end

end
