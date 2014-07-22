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
  @avail_puppies = []

  def self.add_puppy(name, age, breed)
    @avail_puppies << Puppy.new(name, age, breed)
  end

  def self.avail_puppies
    @avail_puppies
  end
end

class PuppyStore
  @all_requests = []

  def self.add_request(customer, breed)
    @all_requests << Request.new(customer, breed)
  end

  def self.all_requests
    @all_requests
  end

  def self.accept(request)
    request.status = :accept
  end

  def self.deny(request)
    request.status = :deny
  end

  def self.sell (puppy, request)
    request.status = :sold
    request.puppy = puppy
    PuppyMill.avail_puppies.delete(puppy)
  end

  def self.view_accepted_orders
    all_requests.select {|x| x.status == :accept}
  end

  def self.view_denied_orders
    all_requests.select {|x| x.status == :deny}
  end

  def self.view_pending_orders
    all_requests.select {|x| x.status.nil? }
  end

  def self.view_completed_orders
    all_requests.select {|x| x.status == :sold}
  end
end
