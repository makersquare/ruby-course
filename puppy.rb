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
    @status = :pending
    @puppy = nil
    @price = pricing[@breed]
  end
end

class PuppyMill
  @avail_puppies = {}
  @all_requests = {
                pending: [],
                accept: [],
                deny: [],
                sold: []
                  }

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
    @all_requests[:pending] << Request.new(customer, breed)
  end

  def self.avail_puppies
    @avail_puppies
  end

  # CHANGE STATUS

  def self.accept(request)
    PuppyMill.status_hash_helper(:accept, request)
  end

  def self.deny(request)
    PuppyMill.status_hash_helper(:deny, request)
  end

  def self.sell (puppy, request)
    PuppyMill.status_hash_helper(:sold, request)
    request.puppy = puppy
    @avail_puppies[puppy.breed].delete(puppy)
  end

  def self.status_hash_helper(new_status, request)
    old_status = request.status
    request.status = new_status
    @all_requests[old_status].delete(request)
    @all_requests[new_status].push(request)
  end

  # VIEW REQUESTS

  def self.all_requests
    @all_requests
  end

  def self.view_accepted_orders
    all_requests[:accept]
  end

  def self.view_denied_orders
    all_requests[:deny]
  end

  def self.view_pending_orders
    all_requests[:pending]
  end

  def self.view_completed_orders
    all_requests[:sold]
  end
end
