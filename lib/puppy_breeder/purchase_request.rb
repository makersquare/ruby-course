#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    @@counter = 1
    attr_accessor :request_id, :status, :breed

    def initialize(breed='mix')
      @request_id = @@counter
      @@counter += 1
      @status = false
      @breed = breed
      RequestRepository.add_request(@request_id,self)
    end
  end



  class RequestRepository
    @@list = Hash.new(0)
    attr_accessor :list

    def add_request
    end


  end
end