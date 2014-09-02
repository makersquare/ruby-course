#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

  class PurchaseRequest

    BREED_TO_PRICE = {golden_retriever: 200, afghan_hound: 300, alaskan_malamute: 400, cocker_spaniel: 500}

    def initialize(breed)
      @breed = breed
      @price = BREED_TO_PRICE[breed]
      PuppyBreeder::RequestManager.add_request(self)
    end

  end
end