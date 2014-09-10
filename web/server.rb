require_relative '../lib/songify.rb'

require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index
  end

  post '/' do
    @songs = Songify.songs.get_all_songs
    erb :index
  end


  run! if __FILE__ == $0
end