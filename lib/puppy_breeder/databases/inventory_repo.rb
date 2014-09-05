require 'pg'

module PuppyBreeder
	module Repos
		class Inventory

			def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
    		# @purchase_array = []
        build_tables
    	end

      def build_tables
        @db.exec(%q[ 
          CREATE TABLE IF NOT EXISTS inventory(
              id serial,
              name text,
              breed text,
              age integer
            )
        ])
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE inventory;
        ])
        build_tables
      end

			# attr_accessor :inventory_hash

			# def initialize
			# 	@inventory_hash = Hash.new
			# end

			# def add_breed_price(breed, price)
			# 	inventory_hash[breed] = {
			# 		:price => price,
			# 		:puppies =>[]
			# 	}
			# end

			def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["breed"], req["age"])
          x.instance_variable_set :@name, req["name"]
          x.instance_variable_set :@breed, req["breed"]
          x.instance_variable_set :@age, req["age"]
          x
        end
      end

      def review_puppies
        result = @db.exec(%q[
          SELECT * FROM inventory;
        ])
        build_request(result.entries)
      end

			def add_puppy_to_inventory(puppy)
				# if inventory_hash[puppy.breed]
				# 	inventory_hash[puppy.breed][:puppies] << puppy
				# else
				# 	raise "Error no breed for puppy!"
				# end
				result = @db.exec(%q[
          INSERT INTO inventory (name, breed, age)
          VALUES ($1, $2, $3);
          ], [puppy.name, puppy.breed, puppy.age])
			end
		end
	end
end