class FeedbackController < ApplicationController
  def update
    @feedback = Comment.find_by_id(params[:id])
    @feedback.text = params[:text]
    if @feedback.save
      flash[:notice] = {type: 'success', message: 'Cool, your feedback was given!'}

    else
      flash[:notice] = {type: 'failure', message: 'Hmmm, something went wrong.'}
    end
    redirect_to root_path and return
  end

end