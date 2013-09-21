require 'will_paginate/array'
class PagesController < ApplicationController
  def index
    if user_signed_in?
      @recent_tasks = get_feed_content(params)
      render template: 'pages/feed' and return
    else
      render template: 'pages/index' and return
    end
  end
  def feed

  end
  def browse
    render template: 'pages/browse'
  end

  def search
    render template: 'pages/search'
  end

  def get_feed_content(params)
    if params[:tab] == 'nearby'
      geocoded_address = get_geocoded_address
      Task.close_to(geocoded_address[0], geocoded_address[1]).paginate(page: params[:page], per_page: 2)
    elsif params[:tab] == 'popular'
      Task.paginate(page: params[:page], per_page: 2).order('id DESC')
    else
      Task.paginate(page: params[:page], per_page: 2).order('id DESC')
    end
  end

  def get_geocoded_address
    if Rails.env.development?
      [42.4439614, -76.5018807]
    else
      [request.location.coordinates[0], request.location.coordinates[1]]
    end

  end
end
