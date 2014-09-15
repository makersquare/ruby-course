require 'pg'

module Songify
	module Repositories
		class Songs
			def initialize(name='songify')
				@db = PG.connect(host: 'localhost', dbname: name)
				build_table
			end

			def build_table
				@db.exec(%q[
					CREATE TABLE IF NOT EXISTS songs(
						id serial PRIMARY KEY,
						title text,
						artist text,
						album text,
						genre integer REFERENCES genres (id)
					)
				])
			end

			def drop_table
				@db.exec("TRUNCATE TABLE songs")
				build_table
			end

			def build_songs(entries)
				entries.map do |song|
					x = Songify::Song.new(song['title'], song['artist'], song['album'])
					x.instance_variable_set :@id, song['id'].to_i
					x.instance_variable_set :@genre_id, song['genre'].to_i
					x
				end
			end

			# parameter could be song id
			def get_a_song(id)
				result = @db.exec(%q[
					SELECT * FROM songs WHERE id = $1
				], [id])
				build_songs(result.entries).first
			end

			def get_songs_by_genre(genre_id)
				result = @db.exec(%q[
					SELECT * FROM songs WHERE genre = $1
				], [genre_id])
				build_songs(result.entries)
			end

			# no parameters needed
			def get_all_songs
				result = @db.exec(%q[
					SELECT * FROM songs
				])
				build_songs(result.entries)
			end

			# parameter should be a song object
			def save_a_song(song, genre)
				result = @db.exec(%q[
					INSERT INTO songs (title, artist, album, genre)
					VALUES ($1, $2, $3, $4)
					RETURNING id],
					[song.title, song.artist, song.album, genre.id]
				)
				song.instance_variable_set :@id, result.entries.first['id'].to_i
			end

			# paramter could be a song id
			def delete_a_song(id)
				@db.exec(%q[
					DELETE FROM songs
					WHERE id = $1],
				[id])
			end
		end
	end
end