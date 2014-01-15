class IntroController < ApplicationController
  before_filter :authenticate_user!
  def onboard
    step = params[:step] ? params[:step] : 1
    render template: "intro/#{step}" and return
  end
end
