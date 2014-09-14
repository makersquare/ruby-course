require_relative '../lib/songify.rb'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'pry-byebug'

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
    if params['query_parameter'] == "genre"
      sym = "genre_id"
      search = Songify.genres.get_a_genre_by_name(params['search_term']).id
    else 
      sym = params['query_parameter']
      search = params['search_term']
    end
    parameter = {}
    parameter[sym] = search

    erb :show_some, :locals => {
      song_list: Songify.songs.get_all_songs_by(parameter)
    }
  end

  get '/new' do
    erb :websongify, :locals => {
      genre_list: Songify.genres.get_all_genres
    }
  end

  # get '/show_genre' do
  #   erb :show_genre, :locals => {
  #     genre_list: Songify.genres.get_all_genres
  #   }
  # end

  # get '/exp' do
  #   erb :genre_maker, :locals => {
  #     genre_list: Songify.genres.get_all_genres
  #   }
  # end

  # post '/exp' do
  #   params['old_genre'].empty? ? passed_genre = params['new_genre'] : passed_genre = params['old_genre']
  #   z = Songify::Genre.new(genre: params['new_genre'])
  #   Songify.genres.save_a_genre(z)
  
  #   erb :genre_maker, :locals => {
  #     genre_list: Songify.genres.get_all_genres
  #   }
  # end

  post '/create' do

    params['old_genre'].empty? ? passed_genre = params['new_genre'] : passed_genre = params['old_genre']


    z = Songify::Genre.new(genre: passed_genre)
    genre_id = Songify.genres.save_a_genre(z)
    
    x = 
      {
        title: params['song_title'], 
        artist: params['song_artist'],
        album: params['song_album'],
        year_published: params['song_yearpublished'].to_i,
        rating: params['song_rating'].to_i,
        genre: z.genre,
        lyrics: params['song_lyrics']
      }
    y = Songify::Song.new(x) 
    Songify.songs.save_a_song(y)
    erb :create, :locals => {
      your_song: Songify.songs.get_a_song(y.id),
      your_genre: passed_genre
      # Songify.genres.get_a_genre(genre_id)
    }
  end

  post '/update_change' do
    erb :update_change, :locals => {
      your_song: Songify.songs.get_a_song(params['song_picked'])
    }
  end

  post '/update' do
    if params['change_parameter'] == "genre"
      sym = "genre_id"
      search = Songify.genres.get_a_genre_by_name(params['change_term']).id
      if search.nil?
        search = Songify.genres.save_a_genre(Songify::Genre.new(params['change_term']))
      end
    else 
      sym = params['change_parameter']
      search = params['change_term']
    end
    parameter = {}
    parameter[sym] = search
    this_song = Songify.songs.get_a_song(params.keys.last.to_i)
    
    updated = Songify.songs.update_song(this_song,parameter).first

    erb :update, :locals => {
      your_song: updated
    }
  end

  get '/delete' do
    erb :delete
  end

  post '/delete' do
    Songify.genres.delete_all
    Songify.songs.delete_all
    @judge = "You Monster!"
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