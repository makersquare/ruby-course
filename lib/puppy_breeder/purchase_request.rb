#Refer to this class as PuppyBreeder::PurchaseRequest

module PuppyBreeder
  class PurchaseRequest
    @@counter = 0
    attr_reader :breed, :request_id
    def initialize(breed)
      @breed = breed
      @request_id = counter += 1
      @purchase_request = {
        @request_id => {
          "breed" => @breed,
          "cost" => 0 #get cost from hash stored in inventory
          #:date = Time.now
          }}
    end
  end
end
