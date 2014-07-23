class Puppy
  attr_reader :name, :age, :breed

  def initialize (name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end
end

class Request
  attr_reader :customer, :breed, :price
  attr_accessor  :status, :puppy

  def initialize (customer, breed)
    pricing = {
      dobermanpinscher: 800,
      chihuahua: 600,
      americanbulldog: 900,
      dingo: 1200,
      poodle: 1500
    }
    @customer = customer
    @breed = breed
    @status = nil
    @puppy = nil
    @price = pricing[@breed]
  end
end

class PuppyMill
  @avail_puppies = {}
  @all_requests = []

  def self.add_puppy(name, age, breed)
    breed = breed.downcase.delete(" ").to_sym
    new_puppy = Puppy.new(name, age, breed)
    if avail_puppies.has_key?(breed) 
      avail_puppies[breed] << new_puppy
    else
      avail_puppies[breed] = [new_puppy]
    end
  end

  def self.add_request(customer, breed)
    breed = breed.downcase.delete(" ").to_sym
    @all_requests << Request.new(customer, breed)
  end

  def self.avail_puppies
    @avail_puppies
  end

  # CHANGE STATUS

  def self.accept(request)
    request.status = :accept
  end

  def self.deny(request)
    request.status = :deny
  end

  def self.sell (puppy, request)
    request.status = :sold
    request.puppy = puppy
    @avail_puppies[puppy.breed].delete(puppy)
  end

  # VIEW REQUESTS

  def self.all_requests
    @all_requests
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
