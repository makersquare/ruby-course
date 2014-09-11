require 'pg'

module Songify
	module Repositories
		class Genres

			def initialize
				@db = PG.connect(host:'localhost', dbname:'songify')
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

			def build_genre(data)
				x = Songify::Genre.new(data['name'], data['id'])
				x.instance_variable_set :@id, data['id'].to_i
				x
			end

			def get_a_genre(genre_id)
				result = @db.exec("SELECT * FROM genres WHERE id=$1", [genre_id])
				build_song(result.first)
			end

			def get_all_genres
				result = @db.exec("SELECT * FROM genres")
				result.map { |r| build_genre(r) }
			end

			def save_a_genre(genre)
				result = @db.exec(%q[
					INSERT INTO genres(name)
					VALUES ($1)
					], [genre.name])
			end

			def delete_a_genre(genre_id)
				@db.exec("DELETE FROM genres WHERE id=$1", [genre_id])
			end

		end
	end
end