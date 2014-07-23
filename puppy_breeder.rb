class PurchaseRequest
  attr_reader :breed_wanted, :purchaser_name
  attr_accessor :accepted

  def initialize(purchaser_name, breed_wanted)
    @purchaser_name = purchaser_name
    @breed_wanted = breed_wanted
    @accepted = false
  end 

end

class PurchaseRequestInventory
  attr_reader :request_array

  def initialize
    @request_array = []
    # binding.pry
  end

  def add_purchase_request(purchase_request)
    @request_array << purchase_request
    # binding.pry
  end

  def view_requests
    @request_array.find {|request| request.accepted == false}
  end

  def accept_purchase_request(purchase_request)
    purchase_request.accepted = true
  end

  def view_completed_orders
    @request_array.find {|request| request.accepted == true}
  end

end

class Puppy
  attr_reader :breed, :name, :age
  attr_accessor :available

  def initialize(breed, name, age)
    @breed = breed
    @name = name
    @age = age
    @available = true
  end

end

class PuppyInventory
  attr_reader :puppy_hash

  def initialize
    @puppy_hash = Hash.new
  end

  def add_puppy_to_inventory(puppy)
    if @puppy_hash.has_key?(puppy.breed)
      @puppy_hash[puppy.breed.to_sym][:list] << puppy
    else
      @puppy_hash[puppy.breed] = {
        :price => :unknown, 
        :list => [puppy]
      }
    end
  end

  def print_puppy_inventory
    @puppy_hash
  end

end


request_inventory = PurchaseRequestInventory.new

puppy_inventory = PuppyInventory.new

puppy1 = Puppy.new(:boxer, "box", 10)
puppy2 = Puppy.new(:boxer, "boxey", 12)
puppy3 = Puppy.new(:pit, "pitty", 15)

puppy_inventory.add_puppy_to_inventory(puppy1)
puppy_inventory.add_puppy_to_inventory(puppy2)
puppy_inventory.add_puppy_to_inventory(puppy3)

request1 = PurchaseRequest.new("Chris", "boxer")
request2 = PurchaseRequest.new("Zach", "boxer")
request3 = PurchaseRequest.new("Aaron", "pit")

request_inventory.add_purchase_request(request1)
request_inventory.add_purchase_request(request2)
request_inventory.add_purchase_request(request3)

puppy_inventory.print_puppy_inventory






