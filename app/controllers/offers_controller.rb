class OffersController < ApplicationController
  before_filter :load_task

  def create
    @offer = Offer.new
    @offer.user = User.find_by_id(params[:user_id])
    @task.offers << @offer
    if @offer.save && @task.save
      render json: {offer: @offer, success: true }
    else
      render json: { success: false }
    end
  end

end
