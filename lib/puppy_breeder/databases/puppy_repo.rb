require 'pg'
require 'pry-byebug'

module PuppyBreeder
  module Repos
    class PuppyRepo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies (
            id serial,
            breed text,
            age int,
            adoption_status text,
            price int
            )
          ])
      end

      def drop_and_rebuild
        @db.exec(%q[
            DROP TABLE puppies;
          ])
        build_tables
      end

      # Add breed when a puppy of that breed is added
      # def add_breed_to_hash(pup)
      #   # @@puppies[breed] = {
      #   #   :price => price,
      #   #   :list => []
      #   # }
      #   @db.exec(%q[
      #       INSERT INTO puppies (breed, age, adoption_status, price)
      #       VALUES ($1, $2, $3, $4);
      #       ], [pup.breed, pup.age, pup.adoption_status, pup.price])
      # end

      # PG READY
      def add_puppy_to_hash(pup)
        # if @@puppies[puppy.breed] == nil
        #     @@puppies[puppy.breed] = {:price => 1000, :list => []}
        # elsif @@puppies[puppy.breed]
        #   @@puppies[puppy.breed][:list] << puppy
        # else
        #   @@puppies[puppy.breed][:list] = [puppy]
        # end
      
        @db.exec(%q[
            INSERT INTO puppies (breed, age, adoption_status, price)
            VALUES ($1, $2, $3, $4);
            ], [pup.breed, pup.age, pup.adoption_status, pup.price])        # binding.pry
      end

      #PG READY
      # Can i do this?
      def change_breed_price(pup)
        # @@puppies[breed][:price] = price
        @db.exec(%q[
            UPDATE puppies (price) WHERE breed = pup.breed
            VALUES ($1); 
          ], [pup.price])
      end



      # @@puppies = {}

      # PG READY
      def puppies
        # @@puppies
        result = @db.exec('SELECT * FROM puppies;')
        build_request(result.entries)
      end

      # PG READY
      def build_request(entries)
        entries.map do |pup|
          x = PuppyBreeder::Puppy.new(pup['name'], pup['breed'], pup['age'], pup['adoption_status'].to_sym, pup['price'].to_i)
          x.instance_variable_set :@id, pup['id'].to_i
          # x.instance_variable_set :@adoption_status, pup["adoption_status"].to_sym
          # x.instance_variable_set :@price, pup["price"].to_i
          x
        end
      end

    end
  end
end

