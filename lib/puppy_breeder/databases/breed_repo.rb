require 'pg'

module PuppyBreeder
  module Repos
    class BreedLog

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def log
        result = @db.exec("SELECT * FROM breeds;")
        build_breed(result.entries)
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds(
            breed text,
            price money
          )
        ])
      end

      def drop_tables
        @db.exec(%q[
          DROP TABLE breeds;
        ])
        build_tables
      end

      def add_breed(breed)
        @db.exec(%q[
          INSERT INTO breeds (breed, price)
            VALUES ($1, $2);
        ], [breed.breed, breed.price])
      end

      def update_price(breed)
        @db.exec(%q[
          UPDATE breeds SET price = $1 WHERE breed = $2;
        ], [breed.price, breed.breed])
      end

      def build_breed(entries)
        entries.map do |req|
          x = PuppyBreeder::Breed.new(req["breed"], req["price"])
          x.instance_variable_set :@breed, req["breed"]
          x.instance_variable_set :@price, req["price"]
          x
        end
      end

    end
  end
end