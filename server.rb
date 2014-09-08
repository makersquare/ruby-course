require_relative 'lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'

get '/' do
  erb :index
end