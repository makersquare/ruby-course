# Create Puppy class, init with name, breed, and age.

class Puppy
  attr_reader :name, :breed, :age

  def initialize(name, breed, age)
    @name = name
    @breed = breed.to_sym
    @age = age
  end
end

class PuppyInv
  # attr_accessor :inventory
  @inventory = {}

  def self.inventory
    @inventory
  end

  def self.add_puppy_to_inventory(name, breed, age)
    if @inventory[breed.to_sym].nil?
      @inventory[breed.to_sym]= {
        price: nil,
        in_inv: 1,
        list: [Puppy.new(name, breed, age)]
      }
    else
      @inventory[breed.to_sym][:in_inv] += 1
      @inventory[breed.to_sym][:list].push(Puppy.new(name, breed, age))
    end

  end

  def self.set_breed_price(breed, price)
    @inventory[breed.to_sym][:price] = price
  end

  def self.check_price(breed)
    @inventory[breed.to_sym][:price]
  end

end

class Request
  attr_accessor :status, :reqlist, :customer, :breed
  @@reqlist = []
  def initialize(customer, breed)
    @customer = customer
    @breed = breed.to_sym
    @status = :pending
    @@reqlist << self
    @request_time = Time.now
  end

  def accepted?
    @status = :accepted
  end

  def onhold?
    @status = :onhold
  end

    def pending?
    @status = :pending
  end

  def check_availability(breed)
    if PuppyInv.inventory[breed.to_sym].nil?
      @status = :onhold
    end
  end

  def show_reqlist
    @@reqlist.each {|x| puts x }
  end

  def view_requests
   @@reqlist.select {|request| request.pending? == true}.sort_by {|request| puts request.request_time}
 end
end



sandra = Request.new("Sandra", "poddle")

 sandra.view_requests




