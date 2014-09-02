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
    @@list = Hash.new
    @@closed_request=[]
    @@pending_request = []
    attr_accessor :number

    def self.add_request(request)
      @number = @@counter
      @@list[@number] = request
      @@pending_request<< request  
      @@counter += 1
    end

    def self.create_request(breed='mix')
      request = PurchaseRequest.new(breed)
      self.add_request(request)
    end

    def self.complete_request(request_id)
      puts "Request #{request_id} has been filled."
      @@closed_request << @@list[request_id]
      @@pending_request.delete(@@list[request_id])
    end

    def self.end_request(request_id)
      puts "Request #{request_id} has been denied. Please contact Animal Protective services."
      @@closed_request << @@list[request_id]
      @@pending_request.delete(@@list[request_id])
    end

    def self.list
      @@list
    end

    def self.pending_list
      @@pending_request
    end

    def self.breed_requested(request_id)
      @@list[request_id].breed      
    end

    def self.completed_list
      @@closed_request
    end

  end
end