class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create,:destroy]
  before_filter :authorized_user, :only => [:destroy]

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash.now[:success] = "Micropost created!"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      @feed_items = []
      respond_to do |format|
        format.html { render 'pages/home' }
        format.js
      end
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private

  def authorized_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end


end
