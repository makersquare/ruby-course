#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest
  
    attr_reader :breed
  
    def initialize(breed, status=:pending)
      @breed = BreedFixer.symbol(breed)
      @status = status
    end
  
    def pending?
      @status == :pending
    end

    def accepted?
      @status == :accepted
    end
    
    def accept!
      @status = :accepted
    end

    def on_hold?
      @status == :on_hold
    end
    
    def on_hold!
      @status = :on_hold
    end    

  end

end