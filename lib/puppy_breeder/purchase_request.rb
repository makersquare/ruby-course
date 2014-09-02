#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :requester, :status
    @@purchase_requests = {}
def self.submit_request(breed, requester, status="pending")
 purchase_request[breed] = {requester: requester, status: "pending" }
end


  end
end