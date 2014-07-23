class PurchaseRequest
  attr_reader :breed_wanted, :purchaser_name, :request_time
  attr_accessor :status

  def initialize(purchaser_name, breed_wanted)
    @purchaser_name = purchaser_name
    @breed_wanted = breed_wanted
    @request_time = Time.now
    @status = "pending"
  end

  def accepted?
    @status == "accepted"
  end

  def pending?
    @status == "pending"
  end

  def on_hold?
    @status == "on hold"
  end

end

class PurchaseRequestInventory
  attr_reader :request_array

  def initialize
    @request_array = []
    # binding.pry
  end

  def add_purchase_request(purchase_request, puppy_inventory)

    if puppy_inventory.puppy_hash.has_key?(purchase_request.breed_wanted.to_sym)
        if puppy_inventory.puppy_hash[purchase_request.breed_wanted.to_sym][:list].map {|x| x.available == true}[0] == true
          @request_array << purchase_request
        end
    else
      purchase_request.status = "on hold"
      @request_array << purchase_request
    end

  end

  def view_requests
    @request_array.select {|request| request.pending? == true}.sort_by {|request| request.request_time}
  end

  def accept_purchase_request(purchase_request, puppy)
    purchase_request.status = "accepted"
    puppy.available = false
  end

  def view_completed_orders
    @request_array.select {|request| request.accepted? == true}
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


#test


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
request4 = PurchaseRequest.new("Emma", "lab")

request_inventory.add_purchase_request(request1, puppy_inventory)
request_inventory.add_purchase_request(request2, puppy_inventory)
request_inventory.add_purchase_request(request3, puppy_inventory)
request_inventory.add_purchase_request(request4, puppy_inventory)

puppy_inventory.print_puppy_inventory

request_inventory.view_requests


  #   need an approval process between puppy being added and accepting request
  # time.now attribute for requests. sort by method for time.





