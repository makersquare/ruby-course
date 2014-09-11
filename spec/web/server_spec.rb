
require 'server_spec_helper'

describe Songify::Server do

let(:test_song1) {Songify::Song.new(title: "Radio Radio",artist: "Elvis Costello",album: "This Year's Model",year_published: 1978)}
let(:test_song2) {Songify::Song.new(title: "Goin' Out West",artist: "Tom Waits",album: "Bone Machine",year_published: 1992)}

  def app
    Songify::Server.new
  end

  describe "GET /index" do
    it "loads the song index" do
      get '/'
      expect(last_response).to be_ok
    end
  end


    
    # it "loads the homepage" do
    #   Songify.songs.save  Songify::Book.new("My First Book", Date.parse('1983-10-29'))
    #   Songify.songs.save  Songify::Book.new("My Second Book", Date.parse('1983-10-29'))

    #   get '/'
    #   expect(last_response).to be_ok
    #   expect(last_response.body).to include "My First Book", "My Second Book"
    

  # describe "POST /songs" do
    
  #   it "creates a book" do
  #     post '/songs', { "name" => "My New Book", "published_at" => "1987-06-12" }
  #     expect(last_response).to be_ok

  #     last_book = Songify.songs.all.last
  #     expect(last_response.body).to eq(last_book.name)
  #   end
  # end


# require_relative '../spec_helper.rb'

# describe Songify::Repos::Songs do

# let(:test_song1) {Songify::Song.new(title: "Radio Radio",artist: "Elvis Costello",album: "This Year's Model",year_published: 1978)}
# let(:test_song2) {Songify::Song.new(title: "Goin' Out West",artist: "Tom Waits",album: "Bone Machine",year_published: 1992)}

#   before(:each) do
#     Songify.songs.drop_table
#   end

#   it "saves a song" do
#     Songify.songs.save_a_song(test_song1)
#     test_answer = Songify.songs.get_all_songs

#     expect(test_song1.artist).to eq(test_answer.first.artist)
#   end

#   it "gets a song by id" do
#     Songify.songs.save_a_song(test_song1)
#     result = Songify.songs.get_a_song(test_song1.id)

#     expect(result.artist).to eq("Elvis Costello")
#     expect(result.title).to eq("Radio Radio")
#     expect(result.year_published).to eq(1978)
#     expect(result.album).to eq("This Year's Model")
#     expect(result.rating).to eq(nil)
#     expect(result.id).to eq(test_song1.id)
#   end

#   it "gets all songs" do
#     Songify.songs.save_a_song(test_song1)
#     Songify.songs.save_a_song(test_song2)
#     test_answer = Songify.songs.get_all_songs

#     expect(test_song1.artist).to eq(test_answer.first.artist)
#     expect(test_song2.artist).to eq(test_answer.last.artist)
#   end

#   it "deletes a song" do
#     Songify.songs.save_a_song(test_song1)
#     Songify.songs.save_a_song(test_song2)
#     result = Songify.songs.delete_a_song(test_song1.id)

#     expect(result.artist).to eq("Elvis Costello")
#     expect(result.title).to eq("Radio Radio")
#     expect(result.year_published).to eq(1978)
#     expect(result.album).to eq("This Year's Model")
#     expect(result.rating).to eq(nil)
#     expect(result.id).to eq(test_song1.id)

#     test_answer = Songify.songs.get_all_songs
#     expect(test_answer.count).to eq(1)
#     expect(test_song2.artist).to eq(test_answer.first.artist)
#   end

#   it "can get all the songs by album or by artist" do
#     Songify.songs.save_a_song(test_song1)
#     Songify.songs.save_a_song(test_song2)
#     Songify.songs.save_a_song(Songify::Song.new(title: "Accidents Will Happen",artist: "Elvis Costello",album: "Armed Forces",year_published: 1979))
#     test_answer = Songify.songs.get_all_songs
#     expect(test_answer.count).to eq(3)
#     test_answer2 = Songify.songs.get_all_songs_by(artist:"Elvis Costello")
#     expect(test_answer2.count).to eq(2)
#     test_answer3 = Songify.songs.get_all_songs_by(album:"Armed Forces")
#     expect(test_answer3.count).to eq(1)
#     expect(test_answer3.first.artist).to eq("Elvis Costello")
#   end

# end


# server spec

# require 'server_spec_helper'

# describe Bookly::Server do

#   def app
#     Bookly::Server.new
#   end

#   describe "GET /" do
#     it "loads the homepage" do
#       Bookly.books_repo.save  Bookly::Book.new("My First Book", Date.parse('1983-10-29'))
#       Bookly.books_repo.save  Bookly::Book.new("My Second Book", Date.parse('1983-10-29'))

#       get '/'
#       expect(last_response).to be_ok
#       expect(last_response.body).to include "My First Book", "My Second Book"
#     end
#   end

#   describe "POST /books" do
#     it "creates a book" do
#       post '/books', { "name" => "My New Book", "published_at" => "1987-06-12" }
#       expect(last_response).to be_ok

#       last_book = Bookly.books_repo.all.last
#       expect(last_response.body).to eq(last_book.name)
#     end
#   end
# end


end

