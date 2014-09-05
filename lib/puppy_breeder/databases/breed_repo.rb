module PuppyBreeder
  module Repos
    class Breeds

      def initialize #test?
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_table
      end

      def build_table #test?
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds(
            breed text PRIMARY KEY, 
            price money
          )
        ]) #can primary key be left out if id serial?
      end

      def destroy #test?
        @db.exec(%q[
          DROP TABLE IF EXISTS breeds
        ])
      end

      def log
        build_table
        result = @db.exec('SELECT * FROM breeds;')
        build_breeds(result.entries)
      end

      def build_breeds(entries) #test?
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