# require 'pry-byebug'
#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :status
    attr_reader :breed, :id, :cost

# Counter for request_id.
    @@counter = 0

# Initializes with breed, request_id, and request_status.
# request_status can be "Pending", "Approved", "Hold" or "Denied".
    def initialize(breed, status="Pending")
      @breed = breed
      @status = status
      @@counter += 1
      @id = @@counter
      puppy_list = PuppyBreeder::puppy_container.puppies
      # binding.pry
      @cost = puppy_list[breed][:price]
    end

# Approves purchase request and changes status to Approved.
    def approve!
      @status = "Approved"
    end

    # Nick's
    # def accepted!
    #   @status = "Accepted"
    # end

# Denies purchase request and changes status to Denied.
    def deny!
      @status = "Denied"
    end

# Nick's:
    def pending?
      @status == "Pending"
    end

    def pending!
      @status = "Pending"
    end

    def accepted?
      @status == "Accepted"
    end

    def hold!
      @status = "Hold"
    end

  end
end    