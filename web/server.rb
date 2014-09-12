require_relative '../lib/songify.rb'
require 'sinatra/base'

class Songify::Server < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/show' do
    @songs = Songify.songs_repo.get_all_songs

    erb :show
  end

  post '/show' do
    @songs = Songify.songs_repo.get_all_songs

    erb :show
  end

  get '/new' do
    @allGenres = Songify.genres_repo.get_all_genres
    erb :new
  end

# 1: upon receipt of post request, get_genre_id is called on the genre parameter,
# returning either a valid genre ID for an existing genre, or returning false for a genre
# that has not been added to the table.
# 2A: If 'test' returns a valid genre ID, the conditional runs the code
# under 'if', instantiating a new Song object from the parameters received by the form,
# adding the new Song object to the table, providing a return value of the song's title,
# and ultimately redirecting the user to the /show page.
# 2B: If test returns 'false', the conditional executes the code in the 'else' statement.
# A new Genre object is instantiated using the genre parameter from the form. The Genre
# objects is added to the genres table; and since the return value of that method is the
# newly-created genre id, that value is set to the variable 'genre_id'. A new Song object
# is instantiated using the parameters from the form and our genre-id variable (since it
# has already been converted to an integer by the save_a_genre/build_genre methods). The
# Song object is added to the songs table, the song's title is returned, and the user
# is redirected to the /show page.
  post '/create' do
    test = Songify.genres_repo.get_genre_id(params["genre"])
    if test
      # genre_id = Songify.genres_repo.get_genre_id(params["genre"])
      song = Songify::Song.new(params["title"], params["artist"], params["album"], test)
      Songify.songs_repo.save_a_song(song)
      song.title
      redirect to('/show')
    else
      genre = Songify::Genre.new(params["genre"])
      genre_id = Songify.genres_repo.save_a_genre(genre)
      song = Songify::Song.new(params["title"], params["artist"], params["album"], genre_id)
      Songify.songs_repo.save_a_song(song)
      song.title
      redirect to('/show')
    end
  end


run! if __FILE__ == $0
end