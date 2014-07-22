class Puppy
  attr_reader :name, :age, :breed

  def initialize (name, age, breed)
    @name = name
    @age = age
    @breed = breed.downcase.delete(" ").to_sym
  end
end

class Request
  attr_reader :customer, :breed, :price
  attr_accessor  :status, :puppy

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
      poodle: 1500
    }
    @price = pricing[@breed]
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

  def self.accept(request)
    request.status = :accept
  end

  def self.deny(request)
    request.status = :deny
  end
end
