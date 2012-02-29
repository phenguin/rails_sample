class UserArticlesController < ApplicationController
  before_filter :authenticate

  def create
    title = params[:title]
    link = params[:link]
    attr = { :title => title, :link => link }
    if title && link
      current_user.bookmark!(Article.create!(attr))
      flash[:success] = "Bookmarked!"
    else
      flash[:error] = "Invalid bookmark page"
    end
    redirect_to root_path
  end

  def mark_read
    @article = Article.find(params[:id])
    current_user.mark_read!(@article)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

end
