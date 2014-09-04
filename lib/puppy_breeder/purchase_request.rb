#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

   class PurchaseRequest

    attr_reader :customer_name, :breed, :received_by
    attr_accessor :status


    def initialize(customer_name, breed, status="pending", received_by)
      @customer_name = customer_name
      @breed = breed
      @status = status
      @received_by = received_by

    end

    def hold
      @status = "hold"
    end

    def accept(breeder)
      if @status == 'hold'
      @status = "accepted"
      breeder.breed_types[self.breed][:list].pop
    end
    end


  end

end