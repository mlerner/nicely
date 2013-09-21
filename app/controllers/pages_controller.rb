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
      query = Task.order("ST_Distance(ST_Transform(tasks.start_xy, 4326), ST_GeographyFromText('SRID=4326;POINT(#{geocoded_address[1]} #{geocoded_address[0]})'))")
      query = query.close_to(geocoded_address[0], geocoded_address[1])
      query.paginate(page: params[:page], per_page: 10)
    elsif params[:tab] == 'popular'
      Task.paginate(page: params[:page], per_page: 10).order('id DESC')
    else
      Task.paginate(page: params[:page], per_page: 10).order('id DESC')
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
