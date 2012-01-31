class GroupsController < ApplicationController

  before_filter :authenticate, :only => :show

  def show
    @group = Group.find(params[:id])
    @weeks = @group.weeks
    logger.debug @weeks
    @week = @weeks.find_by_week_number(1)
    logger.debug @week
    @posts = @week.posts
    @title = "#{@group.name}"
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end

end
