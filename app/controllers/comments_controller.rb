class CommentsController < ApplicationController
  def feedback
    pp params
    redirect_to root_path and return
  end

end