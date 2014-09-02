#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequestContainer

    @@purchase_request_container = []
  
    def self.add_requests(request_object)
      @@purchase_request_container << request_object
    end

    def self.show_completed
      @@purchase_request_container.select {|r| r.accepted? }
    end

    def self.show_pending
      @@purchase_request_container.select {|r| r.pending? }
    end

  end

end