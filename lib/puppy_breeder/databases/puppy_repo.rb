require 'pg'

module PuppyBreeder
  module Repos
    class Puppies
      #@for_sale = {}
      
      def initialize #test?
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables #test?
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id serial,
            name text,
            age int,
            breed text
          )
        ])

        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds(
            breed text,
            price int
          )
        ]) #HOW TO MAKE BREED THE KEY?
      end

      def destroy #test?
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies
        ])
        @db.exec(%q[
          DROP TABLE IF EXISTS breeds
        ])
      end

      def log
        build_tables
        result = @db.exec('SELECT * FROM puppies;')
        build_puppy(result.entries)
      end

      def build_puppy(entries) #test?
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["age"], req["breed"])
          x
        end
      end

      def add_puppy(puppy, price = nil)

        # if !@for_sale[puppy.breed]
        #   @for_sale[puppy.breed] = {
        #     price: price,
        #     count: 1
        #   }
        # else
        #   @for_sale[puppy.breed][:price] = price if !price
        #   @for_sale[puppy.breed][:count] += 1
        # end

        # @for_sale

        @db.exec(%q[
          INSERT INTO puppies (name, age, breed)
          VALUES ($1, $2, $3);
        ], [puppy.name, puppy.age, puppy.breed])

        #if there is an on-hold request for this breed, change to pending
      end

      # def self.purchase(breed)
      #   if !@for_sale[breed] || @for_sale[breed][:count] == 0
      #     return false
      #   else
      #     @for_sale[breed][:count] -= 1
      #   end

      #   @for_sale
      # end

      # def self.for_sale
      #   @for_sale
      # end

    end 
  end
end