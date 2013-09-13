class PagesController < ApplicationController
  def index
    @recent_tasks = Task.last(5)
    render template: 'pages/index'
  end

  def browse
    render template: 'pages/browse'
  end

  def search
    render template: 'pages/search'
  end
end
