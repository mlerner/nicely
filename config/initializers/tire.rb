require 'tire'

Tire.configure{
  url ENV['ELASTIC_SEARCH_URL']
}