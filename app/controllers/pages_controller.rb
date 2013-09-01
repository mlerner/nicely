class PagesController < ApplicationController
  def index
    render template: 'pages/index'
  end
end
