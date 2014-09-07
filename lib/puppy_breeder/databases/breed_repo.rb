module PuppyPalace
  module Repos
    class BreedRepo
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE IF NOT EXISTS breeds(
            breed text,
            price int
            )
          ])
      end

      def drop_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS requests
          ])
      end

      def add_breed(breed,price)
        @db.exec(%q[
          INSERT INTO breeds(breed,price)
          VALUES ($1,$2);
          ], (breed,price))
      end

      def change_breed_price(breed,price)
        @db.exec(%q[
          UPDATE breeds SET price = $2
          WHERE breed = $1;
          ], [breed,price])
      end
    end
  end
end