require 'pg'
require 'pry-byebug'

module PuppyBreeder
  module Repos
  class RequestLog
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder1')
        build_tables#()
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text,
            puppy_id int,
            price money
            );
          ])
      end
#is there a way to add an entry for a specific breed unless that breed
#already exists. is it the || = thing?
      def add_breed(breed, price)
        result = @db.exec('SELECT breed FROM prices')
        breeds = result.entries
        matches = false
        breeds.map do |breed_pair| 
          breed_pair.each do |key, val|
            if val ==breed
              matches = true
            end
          end
        end
        if matches = false
          @db.exec(%q[
          INSERT INTO prices (breed, price)
          VALUES ($1, $2)
          ], [breed, price])
        end
      end

      def get_price_list
        result = @db.exec('SELECT * FROM prices;')
        result.entries
      end
# now what i need to do is add the code that adds the price to the
#   purchase request
      # def build_price_list
      # #look at each of the hashes in the the array
      # entries.map do |req|
      #   x = PuppyBreeder::PurchaseRequest.new(req["breed"])
      #   x.instance_variable_set :@id, req["id"].to_i
      #   x.instance_variable_set :@puppy_id, req["puppy_id"].to_i
      #   x.instance_variable_set :@status, req["status"]
      #   x
      #   end
      # end

      def log
        result = @db.exec('SELECT * FROM requests;') 
        build_request(result.entries)
      end

      def show_holds
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'hold';
          ])
        build_request(result.entries)
      end

      #show requests method gets the pending status records
      def show_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
          ])
        build_request(result.entries)
      end

      def show_accepted_requests

        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'accepted';
          ])
        build_request(result.entries)
      end

      #######################-------#############################
      #checks puppy repo and resolves any holds where a matching
      #puppy is found
      def check_holds
        #gets all hold requests and stores them as a pg
        #result object
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'hold';
          ])
        #calls build request to return the pg hold object
        #as an array of hashes, each hash representing a 
        #record
        holds = build_request(result.entries)
        #gets all available puppies in the puppy repo
        #and returns a pg result object with them
        result = @db.exec(%q[
          SELECT * FROM puppies
          WHERE available = $1;
          ], ["true"])
        #builds out the array with the puppy hash records
        avail_puppies = build_request(result.entries)
        #cycle through the array with request hold objects
        holds.each do |hold|
          #check each object in the avail_puppies to see
          #if there is a puppy with matching breed
          avail_puppies.each do |puppy|
            if puppy.breed == hold.breed
              pup_id = puppy.id
              hold_id = hold.id
              price = get_price(puppy.breed)
              # binding.pry
              update_records(pup_id, hold_id)
            end
          end
        end
      end

      def get_price(breed)
        #it's trying to get the price but it's getting nil because
        #there's no price

        price = @db.exec(%q[
          SELECT price FROM prices 
          WHERE breed = $1;
          ], [breed])
        # binding.pry
        puts "stuff"
        price.entries.first["price"]
      end

      def update_records(pup_id, request_id)

        result = @db.exec(%q[
          UPDATE puppies SET available = 'false'
          RETURNING breed;
          ])
        breed = result.entries.first["breed"]

        price = get_price(breed)
        @db.exec(%q[
          UPDATE requests 
          SET (puppy_id, status, price) = ($1, $2, $3)
          WHERE id = $4;
          ], [pup_id, 'accepted', price, request_id])
        #update the puppy record to change availability
        
      end

      def build_request(entries)
        #look at each of the hashes in the the array
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@id, req["id"].to_i
          x.instance_variable_set :@puppy_id, req["puppy_id"].to_i
          x.instance_variable_set :@status, req["status"]
          x.instance_variable_set :@price, req["price"]
          x
        end
      end

      def add_request(request)
        pups_available = PuppyBreeder.puppy_repo.log.select do |p|
          p.breed == request.breed
        end

        if pups_available.empty?
          request.hold!
        end

        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2)
          RETURNING id;
          ], [request.breed, request.status])
          request.instance_variable_set :@id, result.entries.first["id"]

      end

      # def refresh_tables
      #   @db.exec("DELETE FROM requests WHERE id IS NOT NULL")
      # end
      def refresh_tables
        @db.exec(%q[
        DROP TABLE requests;
        ])
        build_tables
      end
    end
  end
end