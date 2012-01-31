class PostsController < ApplicationController
  def create
    attr = params[:post]
    @week = Week.find(attr[:week_id])
    @post = current_user.posts.build(attr)
    if @post.save!
      flash[:success] = "Cool, man."
      respond_to do |format|
        format.html { redirect_to @week }
        format.js
      end
      
    else
      redirect_to root_path
    end
  end

  def destroy
  end

end
