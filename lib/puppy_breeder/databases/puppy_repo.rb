require 'pg'

module PuppyBreeder
  module Repos
    class Puppies
      
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id serial,
            name text,
            age int,
            breed text,
            price money,
            availability text
          )
        ])
      end

      def destroy_and_rebuild
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies
        ])
        build_table
      end

      def log
        result = @db.exec('SELECT * FROM puppies;')
        build_puppy(result.entries)
      end

      def build_puppy(entries)
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["age"], req["breed"])
          x.instance_variable_set :@price, req["price"]
          x.instance_variable_set :@availability, req["availability"].to_sym
          x.instance_variable_set :@id, req["id"].to_i
          x
        end
      end

      def add_puppy(puppy)
        breeds_available = PuppyBreeder.breed_repo.log.select { |b| b.breed == puppy.breed }

        if breeds_available.first
          puppy.price = breeds_available.first.price
        end

        result = @db.exec(%q[
          INSERT INTO puppies (name, age, breed, price, availability)
          VALUES ($1, $2, $3, $4, $5)
          RETURNING id;
        ], [puppy.name, puppy.age, puppy.breed, puppy.price, puppy.availability])

        puppy.id = result.entries.first["id"].to_i
      end

      def update_prices(breed_array)
        breed_array.each do |b|
          @db.exec(%q[
            UPDATE puppies SET price = $1 WHERE breed = $2;
          ], [b.price, b.breed])
        end
      end

      def update_availability(puppy)
        @db.exec(%q[
            UPDATE puppies SET availability = $1 WHERE id = $2;
          ], [puppy.availability, puppy.id])
      end
      
    end 
  end
end