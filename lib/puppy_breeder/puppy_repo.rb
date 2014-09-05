require 'pg'

module PuppyBreeder
  module Repos
  class Inventory
    # attr_reader :puppies
    # def initialize
    @@puppies = Hash.new #this is the hash for
    # end

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
      build_tables

    end

    def build_tables
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS puppies(
          id serial,
          breed text,
          name text, 
          price monetary, 
          );
        ])
    end

    def log
      #grab the code from the database and then put it into a 
      #data structure we can read
      result = @db.exec('SELECT * FROM puppies;')
      #change it to the arrays and call the build_puppy method
      #to build a ruby object with the data received
      build_puppy(result.entries)
    end

    def build_puppy(entries)
      entries.map do |req|

        x = PuppyBreeder::Inventory.new(req["name"],req["breed"],req["age"])
    end








    def self.add_breed(breed, price) #talked to jimmy about my rough idea for this
      #and he helped me flesh it out
      #should have added an if @puppies[breed]
      #truthyness to test for the breed already
      #existing
      @@puppies[breed] = {
        "price" => price,
        "list" => []
      }
    end

    def self.add_puppy(puppy) #Professor Nick helped here
      #add if else statement - check the new puppy breed against 
      #the hold list and ############################
      if !@@puppies.has_key?(puppy.breed) #professor nick again
        @@puppies[puppy.breed] = {"price" => 9999, "list" => []}
      end

      @@puppies[puppy.breed]["list"] << puppy
      RequestLog.check_hold(puppy)

    end

    def self.puppies
      @@puppies
    end

    # def self.puppies=(puppies)
    #   @@puppies = puppies
    # end

  end
end

#could have set the methods to class methods so
#I didn't ahve to create an instatiated object
