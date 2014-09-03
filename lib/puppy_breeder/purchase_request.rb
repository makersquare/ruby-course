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
    @@hold_list = []
    @@counter = 1
    @@list = Hash.new
    @@completed_list=[]
    @@pending_request = []
    @@denied_request = []
    attr_accessor :number

    ###########@status, and @accepted for the status of the request and whether or not it has been accepted.

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
      @@completed_list << @@list[request_id]
      @@pending_request.delete(@@list[request_id])
    end

    def self.end_request(request_id)
      puts "Request #{request_id} has been denied. Please contact Animal Protective services."
      @@denied_request<< @@list[request_id]
      @@pending_request.delete(@@list[request_id])
    end

    def self.list
      @@list
    end

    def self.deny_list
      @@deny_list
    end

    def self.pending_list
      @@pending_request
    end

    def self.breed_requested(request_id)
      @@list[request_id].breed      
    end

    def self.completed_list
      @@completed_list
    end

    def self.pending_requests
      @@pending_request
    end

    def self.hold_request(request_id)
      @@hold_list << @@list[request_id]
      @@pending_request.delete(@@list[request_id])
    end

    def self.hold_to_pending(request_id)
      @@pending_request << @@list[request_id]
      @@hold_list.delete(@@list[request_id])
    end

    def self.pending_list_kick(breed)
      reconsider = @@pending_request.select {|x| x.breed == breed}
      reconsider.each {|x| puts "Request #{x.request_id} for the #{x.breed} should be reconsidered."}
    end
  end
end