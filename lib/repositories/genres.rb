require 'pg'

module Songify
	module Repositories
		class Genres

			# initializes connection to database, and sets a shortcut to instance 
			# variable @db; also runs the build_table method to check if our data 
			# structure is in place
			def initialize
				@db = PG.connect(host:'localhost', dbname: 'songify')
				build_table
			end

			# if not in place, will build db structure, setting id as primary key
			def build_table
				@db.exec(%q[
						CREATE TABLE IF NOT EXISTS genres(
							id serial PRIMARY KEY,
							name text
							)
					])
			end

			# drops all values from table, and all foreign key connections attached
			# as well, then rebuilds the data structure.
			def drop_table
				@db.exec("DROP TABLE genres CASCADE")
				build_table
			end

			# selects all rows from the table, which returns the PG::Result object, which
			# contains the information we want. We map through the array of hashes it contains
			# and call our build_genre method. The overall result is an array of Genre objects.
			def get_all_genres
				result = @db.exec("SELECT * FROM genres")
				result.map { |r| build_genre(r) }
			end


			# used in conjunction with get_all_genres, build_genre takes the array of
			# hashes in the PG::Result object, and creates a new Genre object based
			# on the values found therein. All keys and values are strings by default
			# so this method also converts the id value it retrieves into a integer. The
			# method then calls the completed object as its return value.
			def build_genre(data)
				x = Songify::Genre.new(data['name'])
				x.instance_variable_set :@id, data['id'].to_i
				x
			end


			# Attempts to retrieve the ID of a genre. If the genre exists in the table,
			# the conditional will return the ID value. If no such genre exists in the table,
			# it returns false. Will be used in server.rb in lieu of has_genre?, since it
			# will provide us the same conditional comparison, but has a usable return.
			def get_genre_id(genrename)
				result = @db.exec("SELECT * FROM genres WHERE name= $1", [genrename])
				array = result.map {|r| build_genre(r)}
				if array.size == 1
					return array.first.id
				end
					return false
			end


			# attempts to select a row from the table whose name matches the argument
			# provided. If there is a match, a new Genre object is built inside an array
			# with the necessary variables set. If there is no match, then the return will
			# be an empty array. Finally, the size of the returned array is checked in a
			# conditional statement; if the value is greater than zero the return value of
			# this method will be true, indicating that the genre is already in the table.
			# Otherwise, the return will be false, indicating that the genre has not yet
			# been entered.
			def has_genre?(genrename)
				result = @db.exec("SELECT * FROM genres where name = $1", [genrename])
				array = result.map {|r| build_genre(r)}
				if array.size == 1
					return true
				end
					return false
			end


			# Takes a genre name and inserts it into the table, generating a serial ID for it
			# and then returning that value.
			def save_a_genre(genrename)
					result = @db.exec(%q[
						INSERT INTO genres(name)
						VALUES ($1)
						], [genrename])
					get_genre_id(genrename)
			end


			def delete_a_genre(genre_id)
				@db.exec("DELETE FROM genres WHERE id=$1", [genre_id])
			end

		end
	end
end