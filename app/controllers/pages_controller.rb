class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @feed_items = current_user.feed
      @users_groups = current_user.groups
      @articles = Article.unread_by(current_user).paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def week
      @title = "Week"
  end

end
