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
            breed text,
            price money
          )
        ]) #HOW TO MAKE BREED THE KEY?
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

      def build_builds(entries) #test?
        entries.map do |req|
          x = PuppyBreeder::Breed.new(req["breed"], req["price"])
          x
        end
      end

      def add_breed(breed, price)
        @db.exec(%q[
          INSERT INTO breeds (breed, price)
          VALUES ($1, $2);
        ], [breed, price])
      end

    end
  end
end