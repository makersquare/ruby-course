#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  module Repos
    class RequestManager

      def initialize
        @db = PG.connect(host: "localhost", dbname: "requestDB")
        @open_requests = []
        @denied_requests = []
        @completed_requests = []
        @held_requests = []
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            breed text,
            price int,
            open boolean,
            denied boolean,
            completed boolean,
            held boolean);
        ])
      end

      #Need to place requests into appropriate arrays above!
      def build_requests(entries, request_manager)
        entries.map do |req| 
          breed = req["breed"]
          price = req["price"]
          open = req["open"]
          denied = req["closed"]
          completed = req["completed"]
          held = req["held"]
          x = PuppyBreeder::PurchaseRequest.new(breed, request_manager)
        end
      end

      def log()
        result = @db.exec('SELECT * FROM requests;')
        build_requests(result.entries)
      end

      def add_request(purchase_request)
        @open_requests.push(purchase_request)
      end

      def approve_request(purchase_request, puppy_manager)
        @open_requests.delete(purchase_request)
        puppy = puppy_manager.find_match(purchase_request)

        if (puppy.is_a?(PuppyBreeder::Puppy))
          @completed_requests.push(purchase_request)
          puppy_manager.remove_puppy_for_sale(puppy)
        else
          @held_requests.push(purchase_request)
        end
      end

      def deny_request(purchase_request)
        @open_requests.delete(purchase_request)
        @denied_requests.push(purchase_request)
      end

      def view_open_requests()
        @open_requests
      end

      def view_completed_requests()
        @completed_requests
      end

      def view_denied_requests()
        @denied_requests
      end

      def view_held_requests()
        @held_requests
      end

      def clear_all_requests()
        @open_requests = []
        @denied_requests = []
        @completed_requests = []
        @held_requests = []
      end

      
    end
  end
end