#puppy class
class Puppy
  attr_reader :id, :breed, :cost, :status
  def initialize
  end
end

#purchase request class
class PurchaseRequest
  attr_reader :puppy, :customer, :request_id
  def initialize
  end
end


#Customer class
class Customer
  attr_reader :customer_ID, :name
  def initialize
  end
end