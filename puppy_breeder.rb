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
    @on_hold_array = []
    # binding.pry

  #   need an approval process between puppy being added and accepting request
  # when a puppy is born, need to automatically make on hold puppies. time.now attribute for requests. sort by method for time.


# @status pending, accepted, on hold
#   def pending?
#     @status == pending
#   end

  end

  def add_purchase_request(purchase_request, puppy_inventory)

    if puppy_inventory.puppy_hash[purchase_request.breed_wanted.to_sym][:list].map {|x| x.available == true}[0] == true
      @request_array << purchase_request
    else
      @on_hold_array << purchase_request
    end
    
  end

  def view_requests
    @request_array.find {|request| request.accepted == false}
  end

  def accept_purchase_request(purchase_request, puppy)
    purchase_request.accepted = true
    puppy.available = false
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
      @puppy_hash[puppy.breed.to_sym] = {
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

request_inventory.add_purchase_request(request1, puppy_inventory)
request_inventory.add_purchase_request(request2, puppy_inventory)
request_inventory.add_purchase_request(request3, puppy_inventory)

puppy_inventory.print_puppy_inventory






