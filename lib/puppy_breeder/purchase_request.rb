#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :requester, :status

    def initialize(breed, breeder, requester, status="pending")
      @breed = breed
      @requester = requester
      @status = status 
      @breeder = breeder

      if breeder.purchase_requests[breed] == nil 
        breeder.purchase_requests[breed] = [{requester: requester, status: "pending" }] 
      else
        breeder.purchase_requests[breed].push({requester: requester, status: "pending" })
      end
    end

    


  end
end