require 'pg'
require 'pry-byebug'

module PuppyBreeder
  module Repos
    class BreedRepo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds (
            breed text,
            price int
            )
          ])
      end

      def add_breed(breed, price)
        @db.exec(%q[
            INSERT INTO breeds (breed, price)
            VALUES ($1, $2);
            ], [breed, price])
      end

      #PG READY
      # Can i do this?
      def change_breed_price(altered_breed, new_price)
        # @@puppies[breed][:price] = price
        @db.exec(%q[
            UPDATE breeds SET price = $1 WHERE breed = $2; 
          ], [new_price, altered_breed])
      end

      def drop_and_rebuild
        @db.exec(%q[
            DROP TABLE breeds;
          ])
        build_tables
      end

      def breeds
        result = @db.exec('SELECT * FROM breeds;')
        build_request(result.entries)
      end

      # PG READY
      def build_request(entries)
        entries.map do |breed|
          x = PuppyBreeder::Breed.new(breed['breed'], breed['price'].to_i)
          x
        end
      end

    end
  end
end
