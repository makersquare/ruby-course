require 'pg'

module PuppyPalace
  module Repos
    class PuppyRepo
      attr_reader :name,:breed,:age

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end
      
      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id serial,
            name text,
            breed text,
            age int
          )
        ])
      end

      def build_request(entries)
        entries.map do |req|
          r = PuppyPalace::Puppy.new(req["name"],req["breed"],req["age"].to_i)
          # r.instance_variable_set :@breed, req["breed"]
          # r.instance_variable_set :@age, req["age"].to_i
          r
        end
      end

      def drop_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies
          ])
      end

      def show_pups
        result = @db.exec('SELECT * FROM puppies')
        build_request(result.entries)
      end

      def add_puppy(puppy)
        @db.exec(%q[
          INSERT INTO puppies(name,breed,age)
          VALUES ($1,$2,$3);
          ], [puppy.name,puppy.breed,puppy.age])
      end
    end
  end
end