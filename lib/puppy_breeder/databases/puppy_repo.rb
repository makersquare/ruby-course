require 'pry-byebug'
require 'pg'

module PuppyBreeder
  module Repos
    class PuppyRepo

# Connects to puppy-breeder-db database.
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
        build_tables
      end

# Builds puppies table.
      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            id SERIAL,
            breed TEXT,
            name TEXT,
            age INT,
            status TEXT,
            cost INT
          );
        ])
      end

# Resets requests table for testing.
      def drop_and_rebuild_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies;
        ])
        build_tables
      end

# Helper method. Builds the request for the puppies database entries.
      def build_request(entries)
        entries.map do |puppy|
          pup = PuppyBreeder::Puppy.new(puppy["breed"], puppy["name"], puppy["age"])
          pup.instance_variable_set :@id, puppy["id"].to_i
          pup.instance_variable_set :@status, puppy["status"]
          pup.instance_variable_set :@cost, puppy["cost"].to_i
          pup
        end
      end

# Returns the data from the puppies table.
      def log
        result = @db.exec('SELECT * FROM puppies;')
        build_request(result.entries)
      end

# Adds an instance of Puppy into the puppies table.
      def add_puppy(puppy)
        @db.exec(%q[
          INSERT INTO puppies (breed, name, age, status, cost)
          VALUES ($1, $2, $3, $4, $5);
        ], [puppy.breed, puppy.name, puppy.age, puppy.status, puppy.cost])
      end

# AVAILABLE PUPPIES
      def show_puppies
        avail = @db.exec(%q[
          SELECT * FROM puppies WHERE status = 'Available';
        ])
        build_request(avail)
      end

# PUPPIES ON HOLD
      def show_held_puppies
        held = @db.exec(%q[
          SELECT * FROM puppies WHERE status = 'On Hold';
        ])
        build_request(held)
      end

# SOLD PUPPIES
      def show_sold_puppies
        sold = @db.exec(%q[
          SELECT * FROM puppies WHERE status = 'Sold';
        ])
        build_request(sold)
      end

      def set_puppy_to_on_hold(puppy)
        @db.exec(%q[
          UPDATE puppies SET status = 'On Hold' WHERE id = $1;
        ], [puppy.id])
      end

      def set_puppy_to_sold(puppy)
        @db.exec(%q[
          UPDATE puppies SET status = 'Sold' WHERE id = $1;
        ], [puppy.id])
      end

    end
  end
end