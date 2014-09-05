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
            name text,
            breed text,
            age int,
            adoption_status text
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
      def add_puppy(pup)
        # if @@puppies[puppy.breed] == nil
        #     @@puppies[puppy.breed] = {:price => 1000, :list => []}
        # elsif @@puppies[puppy.breed]
        #   @@puppies[puppy.breed][:list] << puppy
        # else
        #   @@puppies[puppy.breed][:list] = [puppy]
        # end
      
        @db.exec(%q[
            INSERT INTO puppies (name, breed, age, adoption_status)
            VALUES ($1, $2, $3, $4);
            ], [pup.name, pup.breed, pup.age, pup.adoption_status])
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
          x = PuppyBreeder::Puppy.new(pup['name'], pup['breed'], pup['age'].to_i, pup['adoption_status'].to_sym)
          x.instance_variable_set :@id, pup['id'].to_i
          # x.instance_variable_set :@adoption_status, pup["adoption_status"].to_sym
          # x.instance_variable_set :@price, pup["price"].to_i
          x
        end
      end

    end
  end
end

