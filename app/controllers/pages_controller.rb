class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @groups = current_user.groups
      #@articles = current_user.articles
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
