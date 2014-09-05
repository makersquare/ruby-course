require 'pg'

module PuppyBreeder
  module Repos
    class PuppyLog

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def log
        result = @db.exec("SELECT * FROM puppies;")
        build_puppy(result.entries)
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

        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS breeds(
            breed text,
            price int
          )
        ])
      end

      def drop_tables
        @db.exec(%q[
          DROP TABLE puppies;
        ])

        @db.exec(%q[
          DROP TABLE breeds;
        ])
        build_tables
      end

      def add_breed(breed, price=999)
        @db.exec(%q[
          INSERT INTO breeds (breed, price)
            VALUES ($1, $2);
        ], [breed, price])
      end

      def add_puppy(puppy)
        @db.exec(%q[
          INSERT INTO puppies (name, breed, age)
          VALUES ($1, $2, $3)
        ], [puppy.name, puppy.breed, puppy.age])
      end

      def build_puppy(entries)
        entries.map do |req|
          x = PuppyBreeder::Puppy.new(req["name"], req["breed"], req["age"])
          x.instance_variable_set :@name, req["name"]
          x.instance_variable_set :@breed, req["breed"]
          x.instance_variable_set :@age, req["age"].to_i
          x
        end
      end
    end
  end
end