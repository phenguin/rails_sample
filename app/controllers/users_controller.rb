class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.name}'s Profile"
  end


end
