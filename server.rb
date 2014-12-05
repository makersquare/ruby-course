require 'sinatra'
require './lib/library_plus'
require 'bundler/setup'
require 'sinatra/reloader'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end
