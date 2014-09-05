#Refer to this class as PuppyBreeder::RequestManager
module PuppyBreeder
  module Repos
    class RequestManager

      def initialize
        @db = PG.connect(host: "localhost", dbname: "requestDB")
        build_tables
        #REPLACE THESE WITH THE DB!
        # @open_requests = []
        # @denied_requests = []
        # @completed_requests = []
        # @held_requests = []
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id int,
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

      def add_request(purchase_request)
        #@open_requests.push(purchase_request)
        id = purchase_request.id
        breed = purchase_request.breed
        price = purchase_request.price
        open = true
        denied = false
        completed = false
        held = false
        @db.exec(%q[INSERT INTO requests
          VALUES ($1,$2,$3,$4,$5,$6,$7);], [id, breed, price, open, denied, completed, held])
      end

      def approve_request(purchase_request, puppy_manager)
        # @open_requests.delete(purchase_request)
        # puppy = puppy_manager.find_match(purchase_request)

        # if (puppy.is_a?(PuppyBreeder::Puppy))
        #   @completed_requests.push(purchase_request)
        #   puppy_manager.remove_puppy_for_sale(puppy)
        # else
        #   @held_requests.push(purchase_request)
        # end

        id = purchase_request.id
        @db.exec(%q[UPDATE requests
          SET open = false 
          WHERE id = ($1);], [id])

        puppy = puppy_manager.find_match(purchase_request)
        if (puppy.is_a?(PuppyBreeder::Puppy))
          @db.exec(%q[UPDATE requests
            SET completed = true
            WHERE id = ($1);], [id])
          PuppyBreeder.puppy_repo.remove_puppy_for_sale(puppy)
        else
            @db.exec(%q[UPDATE requests
            SET held = true
            WHERE id = ($1);], [id])
        end


      end

      def deny_request(purchase_request)
        # @open_requests.delete(purchase_request)
        # @denied_requests.push(purchase_request)
        id = purchase_request.id
        @db.exec(%q[UPDATE requests 
          SET open = false, denied = true
          WHERE id = ($1);], [id])
      end

      def view_open_requests()
        # @open_requests
        result = @db.exec(%q[SELECT * FROM requests
          WHERE open = true;])
        requests = build_requests(result, PuppyBreeder.request_repo)
      end

      def view_completed_requests()
        # @completed_requests
        result = @db.exec(%q[SELECT * FROM requests
          WHERE completed = true;])
        requests = build_requests(result, PuppyBreeder.request_repo)
      end

      def view_denied_requests()
        # @denied_requests
        result = @db.exec(%q[SELECT * FROM requests
          WHERE denied = true;])
        requests = build_requests(result, PuppyBreeder.request_repo)
      end

      def view_held_requests()
        # @held_requests
        result = @db.exec(%q[SELECT * FROM requests
          WHERE held = true;])
        requests = build_requests(result, PuppyBreeder.request_repo)
      end

      def clear_all_requests()
        # @open_requests = []
        # @denied_requests = []
        # @completed_requests = []
        # @held_requests = []

        @db.exec(%q[DELETE FROM requests])
        
      end

      
    end
  end
end