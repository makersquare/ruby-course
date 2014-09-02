#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    @@counter = 1
    attr_accessor :request_id, :status, :breed

    def initialize(breed)
      @request_id = @@counter
      @@counter += 1
      @status = false
      @breed = breed
    end
  end



  class RequestRepository
    @@counter = 1
    @@list = Hash.new(0)
    attr_accessor :list

    # def self.add_request(breed='mix')
    #   request = PurchaseRequest.new(breed)
    # end


  end
end