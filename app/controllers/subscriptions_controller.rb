class SubscriptionsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :correct_user, :only => [:create, :destroy]

  def create
    # TODO
  end

  def destroy
    @subscription.destroy
    flash[:success] = 'Successfully unsubscribed'
    redirect_to user_path(@user)
  end

  private

  def correct_user
    @subscription = Subscription.find(params[:id]).destroy
    @user = User.find(@subscription.user_id)
    redirect_to root_path unless current_user?(@user)
  end

end
