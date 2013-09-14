class PagesController < ApplicationController
  def index
    if user_signed_in?
      render template: 'pages/feed' and return
    else
      @recent_tasks = Task.last(5)
      render template: 'pages/index' and return
    end
  end

  def browse
    render template: 'pages/browse'
  end

  def search
    render template: 'pages/search'
  end
end
