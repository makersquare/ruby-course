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
            price money
          )
        ])
      end

      def destroy
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies
        ])
        build_table
      end

      def log
        build_table
        result = @db.exec('SELECT * FROM puppies;')
        build_puppy(result.entries)
      end

      def build_puppy(entries)
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["age"], req["breed"])
          x.instance_variable_set :@price, req["price"]
          x
        end
      end

      def add_puppy(puppy)
        breeds_available = PuppyBreeder.breed_repo.log.select { |b| b.breed == puppy.breed }

        if breeds_available.first
          puppy.price = breeds_available.first.price
        end

        @db.exec(%q[
          INSERT INTO puppies (name, age, breed, price)
          VALUES ($1, $2, $3, $4);
        ], [puppy.name, puppy.age, puppy.breed, puppy.price])

        #if there is an on-hold request for this breed, change to pending
      end

      def update_prices(breed_array)
        breed_array.each do |b|
          @db.exec(%q[
            UPDATE puppies SET price = $1 WHERE breed = $2;
          ], [b.price, b.breed])
        end
      end

    end 
  end
end