require_relative '../lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end