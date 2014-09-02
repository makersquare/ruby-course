#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def request_dog(dog, breeder)
      breeder.pending(dog, self)
    end

  end
end

