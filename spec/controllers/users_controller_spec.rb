require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do 

    before(:each) do
      @user = Factory(:user)
    end

    it 'should be successful' do
      get :show, :id => @user
      response.should be_success
    end

    it 'should find the right user' do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it 'should have the right title' do
      get 'show', :id => @user
      response.should have_selector( 'title', :content => @user.name)
    end

    it 'should include the users name' do
      get 'show', :id => @user
      response.should have_selector( 'h1', :content => @user.name)
    end

    it 'should have a profile image' do
      get 'show', :id => @user
      response.should have_selector( 'h1>img', :class => 'gravatar')
    end

  end

  describe "GET 'new'" do

    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "displays the right title" do
      get 'new'
      response.should have_selector( "title", :content => "Sign up" )
    end

  end

  describe 'POST create' do

    describe 'failure' do

      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
          :password_confirmation => ""}
      end

      it 'should not create a new user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User,:count)
      end

      it 'should have the right title' do
        post :create, :user => @attr
        response.should have_selector( 'title', :content => "Sign up")
      end

      it 'should render the new page' do
        post :create, :user => @attr
        response.should render_template('new')
      end

    end

    describe 'success' do

      before(:each) do
        @attr = { :name => 'Valid User', :email => 'validemail@example.com',
          :password => 'secrets', :password_confirmation => 'secrets' }
      end

      it 'should display a welcome message' do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end

      it 'should create a new user' do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it 'should redirect to the user show page' do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it 'should automatically sign the user in' do
        post :create, :user => @attr
        controller.should be_signed_in
      end

    end

  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "returns http success" do
      get 'edit', :id => @user
      response.should be_success
    end

    it "displays the right title" do
      get 'edit', :id => @user
      response.should have_selector( "title", :content => "Edit user" )
    end

    it "should have a link to change the gravatar" do
      get 'edit', :id => @user
      gravatar_path =  "http://gravatar.com/emails"
      response.should have_selector( "a", :href => gravatar_path,
                                    :content => "Change" )
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :name => "",:password => "",
          :password_confirmation => "" }
      end

      it "should render the edit page" do
        put :update, :id => @user, :user => @attr
        response.should be_success
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector( 'title', :content => "Edit user" )
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :email => "new@example.com", :name => "New Name",:password => "secret",
          :password_confirmation => "secret" }
      end

      it "should change the users attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/i
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non signed in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        get :update, :id => @user
        response.should redirect_to(signin_path)
      end

    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@wrong.com")
        test_sign_in(wrong_user)
      end
      
      it "should require matchings users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matchings users for 'update'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

    end
  end
  describe "GET 'index'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /log in/i
      end
    end

    describe "for signed-in users" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        second = Factory(:user, :name => "Bob", :email => "another@example.com")
        third = Factory(:user, :name => "Ben", :email => "another@example.net")

        @users = [@user, second, third]
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector( 'title', :content => "All users")
      end

      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end

    end
  end

end

