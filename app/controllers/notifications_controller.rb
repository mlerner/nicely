class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = User.find_by_id(params[:user_id])
    redirect_to user_path(@user) and return unless current_user.id == @user.id
    @notifications = Notification.where(user_id: params[:user_id])
    @notifications.each do |notification|
      notification.read_date = Time.now
      notification.save
    end
    render template: 'notifications/index' and return
  end
end