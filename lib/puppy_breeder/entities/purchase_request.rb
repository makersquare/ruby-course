#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

  class PurchaseRequest

    attr_reader :breed, :price

    BREED_TO_PRICE = {"golden retriever" => 200, "afghan hound" => 300, 
    "alaskan malamute" => 400, "cocker spaniel" => 500}

    #unknown breeds default to 250
    def initialize(breed)
      @breed = breed
      @price = BREED_TO_PRICE[breed] || 250
      PuppyBreeder::RequestManager.add_request(self)
    end

  end
end