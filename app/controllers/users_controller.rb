class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render "users/#{@user.id}"
    else
      @title = "Sign up"
      @errors = @user.errors.full_messages
      @user = User.new
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.name}'s Profile"
  end


end
