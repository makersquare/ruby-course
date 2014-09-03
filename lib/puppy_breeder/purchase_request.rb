#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :breeder, :requester, :status

    def initialize(breed, breeder, status="pending")
      @breed = breed
      @status = status 
      @breeder = breeder
      @breeder.purchase_requests << self
    end

    # def self.pending?
    #   @status == "pending"
    # end

    # def self.completed?
    #   @status == "completed"
    # end

    # def self.accept!
    #   @status = "completed"
    # end
    


  end
end

