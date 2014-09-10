require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  get '/' do
    @songs = Songify.songs_repo.all
    erb :index
  end

  # post '/books' do
  #   song = Songify::Songs.new(params["name"], Date.parse(params["published_at"]))
  #   Bookly.books_repo.save(book)
  #   book.name
  # end

end