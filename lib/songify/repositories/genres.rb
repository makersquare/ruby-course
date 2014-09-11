require 'pg'

module Songify
	module Repositories
		class Genres
			def initialize(name='songify')
				@db = PG.connect(host: 'localhost', dbname: name)
				build_table
			end

			def build_table
				@db.exec(%q[
					CREATE TABLE IF NOT EXISTS genres(
						id serial,
						name text
					)
				])
			end

			def drop_table
				@db.exec("DROP TABLE genres")
				build_table
			end

			def build_genres(entries)
				entries.map do |genre|
					x = Songify::Genre.new(genre['name'])
					x.instance_variable_set :@id, genre['id'].to_i
					x
				end
			end

			# parameter could be song id
		# 	def get_a_genre(id)
		# 		result = @db.exec(%q[
		# 			SELECT * FROM genres WHERE id = $1
		# 		], [id])
		# 		build_genres(result.entries).first
		# 	end

		# 	# no parameters needed
			def get_all_genres
				result = @db.exec(%q[
					SELECT * FROM genres
				])
				build_genres(result.entries)
			end

		# 	# parameter should be a song object
			def save_a_genre(genre)
				result = @db.exec(%q[
					INSERT INTO genres (name)
					VALUES ($1)
					RETURNING id],
					[genre.name]
				)
				genre.instance_variable_set :@id, result.entries.first['id'].to_i
			end

		# 	# paramter could be a song id
		# 	def delete_a_song(id)
		# 		@db.exec(%q[
		# 			DELETE FROM songs
		# 			WHERE id = $1],
		# 		[id])
		# 	end
		end
	end
end