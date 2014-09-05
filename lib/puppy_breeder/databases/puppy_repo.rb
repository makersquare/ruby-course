#Refer to this class as PuppyBreeder::PuppyContainer
require 'pry-byebug'
require 'pg'

module PuppyBreeder
  module Repos
    class PuppyRepo

      # Refactored
      # @@puppies = {}

  # Access puppies hash.
      attr_accessor :puppies

  # Initialization creates a name variable and an empty hash with default value of 0.
      def initialize
        # @puppies = Hash.new
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
        build_tables
      end

# Builds tables each time the request is initialized
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

      def drop_and_rebuild_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS puppies;
        ])

        build_tables
      end

# Helper method. Builds the request for database entries.
      def build_request(entries)
        entries.map do |puppy|
          x = PuppyBreeder::Puppy.new(puppy["breed"], puppy["name"], puppy["age"])
          x.instance_variable_set :@id, puppy["id"].to_i
          x.instance_variable_set :@status, puppy["status"]
          x
        end
      end

# Returns the data from the database.
      def log
        result = @db.exec('SELECT * FROM puppies;')
        build_request(result.entries)
      end

  # Adds breed and cost of breed to container.
      # def add_breed(breed, cost=1000)
      #   # @puppies[breed] = { 
      #   #   :price => cost,
      #   #   :available_puppies => []
      #   # }

      #   @db.exec(%q[
      #     INSERT INTO puppies (breed)
      #     VALUES ($1);
      #   ], [breed])

      # end

      # Refactored
      # def self.add_breed(breed, price=1000)
      #   @@puppies[breed] = {
      #     :price => price, 
      #     :list => []
      #   }
      # end

  # Adds a puppy to container. Puppy's breed must be added to container before puppy of that breed can be added, that way a price and available puppies array can be already established.
      def add_puppy(puppy)
        # if @puppies[puppy.breed]
        #   @puppies[puppy.breed][:available_puppies] << puppy
        # else
        #   raise "No breed for puppy."
        # end

        # breeds_available = log.select { |p| p.breed }
        # add_breed(puppy.breed) if !breeds_available.include?(puppy.breed)

        @db.exec(%q[
          INSERT INTO puppies (breed, name, age)
          VALUES ($1, $2, $3);
        ], [puppy.breed, puppy.name, puppy.age])
      end

      # Refactored
      # def self.add_puppy(puppy)
      #   if @@puppies[puppy.breed]
      #     @@puppies[puppy.breed][:list] << puppy
      #   else
      #     raise "No Breed for that Puppy!"
      #   end
      # end

# Returns all puppies from database.
      def show_puppies
        result = @db.exec(%q[
          SELECT * FROM puppies;
        ])
        build_request(result)
      end

  # Removes puppy from :available_puppies array if that puppy is available.
      def remove_puppy(puppy)
        if @puppies[puppy.breed][:available_puppies].include?(puppy)
          @puppies[puppy.breed][:available_puppies].delete(puppy)
        end
      end

  # Finds out whether that breed of puppy is available.
      def breed_availability(breed)
        if !@puppies.has_key?(breed)
          return nil
        elsif !@puppies[breed][:available_puppies].empty?
          @puppies[breed][:available_puppies]
        end
      end

  # Get info of @@puppies
      # Refactored
      # def self.get_breed_price(breed)
      #   @@puppies[breed][:price]
      # end

      # def self.puppy_info
      #   @@puppies
      # end

    end
  end
end