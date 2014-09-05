#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder

  module Repos
    class PuppyManager

      def initialize
        @db = PG.connect(host: "localhost", dbname: "puppyDB")
        #REPLACE THIS WITH THE DB! 
        #@puppies_for_sale = []
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS puppies(
            name text,
            breed text,
            age int);
          ])
      end

      def build_puppies(entries)
        entries.map do |pup|
          name = pup["name"]
          breed = pup["breed"] 
          age = pup["age"].to_i
          x = PuppyBreeder::Puppy.new(name, breed, age)
        end
      end

      def log()
        result = @db.exec('SELECT * FROM puppies;')
        build_puppies(result.entries)
      end

      def check_held_requests(request_manager)
         request_manager.view_held_requests
      end

      #tricky one
      def add_puppy_for_sale(puppy, request_manager)
        # @puppies_for_sale.push(puppy)
        # #If a  matching held request is found
        # held_requests = check_held_requests
        # match = held_requests.find {|req| find_match(req) != nil}
        # if (match.is_a?(PuppyBreeder::Puppy))
        #   request_manager.approve_request(match)
        # end

        db.exec(%q[
          INSERT INTO puppies (name, breed, age)
          VALUES ($1, $2, $3);],
          [puppy.name, puppy.breed, puppy.age])

        held_requests = check_held_requests
        match = held_requests.find {|req| find_match(req) != nil}
        if (match.is_a?(PuppyBreeder::Puppy))
        request_manager.approve_request(match)
        end


      end

      def remove_puppy_for_sale(puppy)
        #@puppies_for_sale.delete(puppy)
        @db.exec(%q[
          DELETE FROM puppies
          WHERE name = ($1);],
          [puppy.name])
      end

      def puppies_for_sale()
        #@puppies_for_sale
        result = @db.exec(%q[
          SELECT * FROM puppies;])
        build_puppies(result)
      end

      def clear_puppies()
        #@puppies_for_sale = []
        @db.exec(%q[DELETE * FROM puppies;])
      end

      def find_match(purchase_request)
        # desired_breed = purchase_request.breed
        # puppies = puppies_for_sale
        # match = puppies.find { |pup| pup.breed == desired_breed }

        desired_breed = purchase_request.breed
        result = @db.exec(%q[
          SELECT * FROM puppies
          WHERE breed = ($1);],
          [desired_breed])

        puppies = build_puppies(result)
        match = puppies.first
      end

    end
  end
end