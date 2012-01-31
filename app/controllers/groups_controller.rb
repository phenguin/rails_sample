class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
    @weeks = @group.weeks
    @week = @weeks.find_by_week_number(1)
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
