class AffiliationsController < ApplicationController

  def create
    @group = Group.find(params[:affiliation][:group_id])
    current_user.group_join!(@group)
    redirect_to @group
  end

  def destroy
    @group = Affiliation.find(params[:id]).group
    current_user.group_leave!(@group)
    redirect_to @group

  end
end
