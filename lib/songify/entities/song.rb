module Songify
	class Song
		attr_reader :title, :artist, :album, :id, :genre_id

		def initialize(title, artist, album)
			@title = title
			@artist = artist
			@album = album
			@id = nil
			@genre_id = nil
		end
	end
end