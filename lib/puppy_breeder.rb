require 'pry-byebug'
require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'

# we initialize the module here to use in our other files
module PuppyBreeder
  class PuppyDelivery

    def self.match_request_to_puppy(request_object)
      desired_breed = request_object.breed
      if PuppyBreeder::PuppyContainer.check_breed(desired_breed) && PuppyBreeder::PuppyContainer.puppy_info(desired_breed).length > 1
        request_object.accept!
        PuppyBreeder::PuppyContainer.get_puppy(breed)
      else
        request_object.on_hold!
      end
    end
     
    def self.match_puppy_to_request(puppy_object)
      breed_on_hand = puppy_object.breed
      request_object = if PuppyBreeder::PurchaseRequestContainer.next_hold(breed_on_hand) || PuppyBreeder::PurchaseRequestContainer.next_pending(breed_on_hand)
        request_object.accept!
        PuppyBreeder::PuppyContainer.get_puppy(breed_on_hand)
      end
    end
  end
end