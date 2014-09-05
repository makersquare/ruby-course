#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

  class PurchaseRequest
    @@count = 1

    attr_reader :breed, :price, :id

    BREED_TO_PRICE = {"golden retriever" => 200, "afghan hound" => 300, 
    "alaskan malamute" => 400, "cocker spaniel" => 500}

    #unknown breeds default to 250
    def initialize(breed, request_manager)
      @breed = breed
      @price = BREED_TO_PRICE[breed] || 250
      @id = @@count
      request_manager.add_request(self)
      @@count +=1 
    end

  end
end