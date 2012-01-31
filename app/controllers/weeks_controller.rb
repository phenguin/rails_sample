class WeeksController < ApplicationController

  def show
    @week = Week.find(params[:id])
    @posts = @week.posts
  end

end
