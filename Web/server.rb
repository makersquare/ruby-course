require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application
  set :bind, '0.0.0.0'
  get '/' do 
    erb :index
  end
  run!

  get '/show' do 
    
end

