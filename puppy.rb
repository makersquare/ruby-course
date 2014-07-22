class Puppy
  attr_reader :name, :age, :breed

  def initialize (name, age, breed)
    @name = name
    @age = age
    @breed = breed.downcase.delete(" ").to_sym
  end
end

class Request
  attr_reader :customer, :breed
  attr_accessor  :status, :puppy, :price

  def initialize (customer, breed)
    @customer = customer
    @breed = breed.downcase.delete(" ").to_sym
    @status = nil
    @puppy = nil
    pricing = {
      dobermanpinscher: 800,
      chihuahua: 600,
      americanbulldog: 900,
      dingo: 1200,
    }
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

  def self.update_request_status(request, new_status)
  end
end
