require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  set :bind, "0.0.0.0"

  get '/index' do
    erb :index
  end

  post '/show' do
    "Test"
  end


  run! if __FILE__ == $0
end
