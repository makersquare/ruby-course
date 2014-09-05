module PuppyBreeder
  module Repos
    class Breeds

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds(
            breed text PRIMARY KEY, 
            price money
          )
        ]) #can primary key be left out of id serial?
      end

      def destroy 
        @db.exec(%q[
          DROP TABLE IF EXISTS breeds
        ])
        build_table
      end

      def log
        build_table
        result = @db.exec('SELECT * FROM breeds;')
        build_breeds(result.entries)
      end

      def build_breeds(entries)
        entries.map do |req|
          x = PuppyBreeder::Breed.new(req["breed"], req["price"])
          x
        end
      end

      def add_breed(breed_type)
        @db.exec(%q[
          INSERT INTO breeds (breed, price)
          VALUES ($1, $2);
        ], [breed_type.breed, breed_type.price])
      end

    end
  end
end