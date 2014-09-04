#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder

  module Repos
    class PuppyManager

      @@puppies_for_sale = []

      def self.check_held_requests()
         PuppyBreeder::RequestManager.view_held_requests
      end

      def self.add_puppy_for_sale(puppy)
        @@puppies_for_sale.push(puppy)

        #If a  matching held request is found
        held_requests = check_held_requests
        match = held_requests.find {|req| find_match(req) != nil}
        if (match.is_a?(PuppyBreeder::Puppy))
          PuppyBreeder::RequestManager.approve_request(match)
        end
      end

      def self.remove_puppy_for_sale(puppy)
        @@puppies_for_sale.delete(puppy)
      end

      def self.puppies_for_sale()
        @@puppies_for_sale
      end

      def self.clear_puppies()
        @@puppies_for_sale = []
      end

      def self.find_match(purchase_request)
        desired_breed = purchase_request.breed
        puppies = puppies_for_sale
        match = puppies.find { |pup| pup.breed == desired_breed }
      end

    end
  end
end