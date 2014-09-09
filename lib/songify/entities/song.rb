module Songify
  class Song

  attr_accessor :song_name, :artist, :album, :song_id

  def initialize(song_name, artist, album, song_id=nil)
    @song_name = song_name
    @artist = artist
    @album = album
    @song_id = song_id
  end  

  end    
end  
