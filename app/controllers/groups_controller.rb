class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
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
