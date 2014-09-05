require 'pg'
module PAWS
  module Repos
    class BreedRepo

      def initialize
        @db = PG.connect(host:'localhost',dbname:'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS price_list(
            breed text UNIQUE,
            price money
            )
          ])
      end

      def add_breed(breed)
        begin
          result = @db.exec(%q[
            INSERT INTO price_list (breed,price)
            VALUES ($1, $2)
            RETURNING * ;
          ], [breed.breed,breed.price])
          result.entries.first
        rescue  PG::UniqueViolation
          puts "That breed already exists."
        end
      end

      def change_breed_price_by_hand(breed)
        result = @db.exec(%q[
          UPDATE price_list
          SET price = $1
          WHERE breed = $2
          RETURNING * ;
        ], [breed.price,breed.breed])
        result.entries.first
      end

      def add_breed_by_hand(breed,price)
        begin
          result = @db.exec(%q[
            INSERT INTO price_list (breed,price)
            VALUES ($1, $2)
            RETURNING * ;
          ], [breed,price])
          result.entries.first
        rescue  PG::UniqueViolation
          puts "That breed already exists."
        end
      end

      def change_breed_price_by_hand(breed,price)
        result = @db.exec(%q[
          UPDATE price_list
          SET price = $1
          WHERE breed = $2
          RETURNING * ;
        ], [price,breed])
        result.entries.first
      end

      def get_price(breed)
        result = @db.exec(%q[
          SELECT price FROM price_list WHERE breed = $1;
          ], [breed])
        result.entries.first["price"]
      end

      def drop_table
        @db.exec(%q[
          DROP TABLE price_list
          ])
        build_tables
      end

    end
  end
end
