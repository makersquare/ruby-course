#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

class PurchaseRequest

  attr_reader :customer_name, :breed
  attr_accessor :status


  def initialize(customer_name, breed, status="pending")
    @customer_name = customer_name
    @breed = breed
    @status = status
  end
end

end