require 'pg'

module PuppyBreeder
  module Repos
    class Puppies
      #@for_sale = {}
      
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id serial,
            name text,
            age int,
            breed text
          )
        ])
      end

      def log
        result = @db.exec('SELECT * FROM puppies;')
        build_request(result.entries)
      end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["age"], req["breed"])
          
        end
      end

      def self.add(puppy, price = nil)

        if !@for_sale[puppy.breed]
          @for_sale[puppy.breed] = {
            price: price,
            count: 1
          }
        else
          @for_sale[puppy.breed][:price] = price if !price
          @for_sale[puppy.breed][:count] += 1
        end

        @for_sale
      end

      def self.purchase(breed)
        if !@for_sale[breed] || @for_sale[breed][:count] == 0
          return false
        else
          @for_sale[breed][:count] -= 1
        end

        @for_sale
      end

      def self.for_sale
        @for_sale
      end

    end 
  end
end