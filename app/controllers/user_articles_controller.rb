class UserArticlesController < ApplicationController
  before_filter :authenticate

  def bookmark
    title = params[:title]
    link = params[:link]
    attr = { :title => title, :link => link }
    if title && link
      current_user.bookmark!(Article.create!(attr))
      flash[:success] = "Bookmarked!"
    end
    redirect_to root_path
  end

end
