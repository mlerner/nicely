class FeedbackController < ApplicationController
  def create
    @feedback = Comment.new
    @feedback.user = params[:user_id]
    if @feedback.save
      flash[:notice] = {type: 'success', message: 'Cool, your feedback was given!'}

    else
      flash[:notice] = {type: 'failure', message: 'Hmmm, something went wrong.'}
    end
    redirect_to root_path and return
  end

end