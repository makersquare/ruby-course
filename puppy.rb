class Puppy
  attr_reader :name, :age, :breed

  def initialize (name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end
end

class Request
  attr_reader :customer, :breed, :status, :puppy, :price

  def initialize (customer, breed)
    @customer = customer
    @breed = breed
    @status = nil
    @puppy = nil
    @price = nil
  end
end

class PuppyMill
  @puppylist = []

  def self.add_puppy(name, age, breed)
    @puppylist << Puppy.new(name, age, breed)
  end

  def self.puppylist
    @puppylist
  end
end

class PuppyStore
  @requestlist = []

  def self.add_request(customer, breed)
    @requestlist << Request.new(customer, breed)
  end

  def self.requestlist
    @requestlist
  end

end