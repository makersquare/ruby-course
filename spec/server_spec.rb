#write for index show new create

require 'server_spec_helper'

describe Songify::Server do 
  def app
    Songify::Server.new
  end

  describe 'GET /' do 
    it 'loads the homepage' do
      # song = Songify::Song.new("Booty Pop", "Hootie hoo", "Booty songs")
      # Songify.songs_repo.save_a_song(song)
      get '/'
      expect(last_response).to be_ok
      # expect(last_response.body).to include 'Booty Pop'
    end
  end
end