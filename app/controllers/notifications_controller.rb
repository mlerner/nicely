class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = User.find_by_id(params[:user_id])
    redirect_to user_path(@user) and return unless current_user.id == @user.id
    @notifications = Notification.where(user_id: params[:user_id])
    render template: 'notifications/index' and return
  end
end