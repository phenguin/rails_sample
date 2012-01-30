class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    @topic_ids = params[:topics][:id]
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to ThisMonth!"

      @topic_ids.each do |id|
        @topic = Topic.find_by_id(id)
        @user.subscribe!(@topic)
        logger.debug(@topic.name)
      end

      redirect_to user_path(@user)
    else
      @title = "Sign up"
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User removed."
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.name}'s Profile"
  end

  def edit
    @title =  "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Updated attributes"
      redirect_to user_path(@user)
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id]) 
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless signed_in? && current_user.admin?
  end

end
