require_relative '../lib/songify.rb'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

class Songify::Server < Sinatra::Application
  get '/' do
    erb :home
  end

  get '/show' do
    erb :index, :locals => {
      song_list: Songify.songs.get_all_songs
    }
  end

  get '/show_some' do
    erb :show_some
  end

  post '/show_some' do
    sym = params['query_parameter'].to_sym
    search = params['search_term']
    parameter = {}
    parameter[sym] = search

    erb :show_some, :locals => {
      song_list: Songify.songs.get_all_songs_by(parameter)
    }
  end

  get '/new' do
    erb :websongify
  end

  post '/create' do
    x = 
      {
        title: params['song_title'], 
        artist: params['song_artist'],
        album: params['song_album'],
        year_published: params['song_yearpublished'],
        rating: params['song_rating']
      }
    y = Songify::Song.new(x) 
    Songify.songs.save_a_song(y)

    erb :create, :locals => {
      your_song: Songify.songs.get_a_song(y.id)
    }
  end

  get '/delete' do
    erb :delete
  end

  post '/delete' do
    Songify.songs.delete_all
    @judge = "Monster!"
    erb :delete
  end

  run! if __FILE__ == $0
end

# <select name='song_rating'>
#   <option value="1">1</option>
#   <option value="2">2</option>
#   <option value="3">3</option>
#   <option value="4">4</option>
#   <option value="5">5</option>
#   </select><br>
#   

# <div>
# <div> <label for='song_id'>One song (by id)</label> </div>
# <div> <input type='text' name='song_id'> </div>
# </div>
# <div><input type='submit' name='one-song'></div>

# <div>
# <div> <label for='song_id'>One song (by id)</label> </div>
# <div> <input type='text' name='song_id'> </div>
# </div>