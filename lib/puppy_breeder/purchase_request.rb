#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def request_dog(breed, breeder)
      breeder.pending(breed, self)
    end

  end
end

