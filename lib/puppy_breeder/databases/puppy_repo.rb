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

      def add_puppy(puppy)
        result = @db.exec(%q[
          INSERT INTO puppies (name, breed, age)
          VALUES ($1, $2, $3)
          RETURNING id;
        ], [puppy.name, puppy.breed, puppy.age])
        puppy.instance_variable_set("@id", result[0]["id"])
      end

      def update_puppy(puppy)
        @db.exec(%q[
          UPDATE puppies SET name = $1, breed = $2, age = $3
          WHERE id = $4
        ], [puppy.name, puppy.breed, puppy.age, puppy.id])
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