class Puppy

  attr_accessor :breed, :age
  attr_reader :name

  def initialize(name, breed, age)
    @name = name.capitalize
    @breed = breed.to_sym
    @age = age
  end

  def bark
    "BARK!"
  end
end

class Request
  attr_reader :c_name, :breed
  attr_accessor :status

  def initialize(c_name, breed, status=:queued)
    @c_name = c_name.capitalize
    @breed = breed.to_sym
    @status = status
  end

  def deny
    @status = :denied
  end

  def satisfied
    @status = :satisfied
  end

  def pending
    @status = :pending
  end

  def hold
    @status = :holding
  end
end

# This is the Store class. It keeps track of requests, statuses, and breed prices.

class Store
  attr_accessor :all_puppies
  attr_reader :name, :owner, :breed_prices, :all_requests

  def initialize(name, owner)
    @name = name
    @owner = owner
    # @requests_by_status = Hash.new(0)
    @all_requests = Array.new(0)
    @breed_prices = Hash.new(0)
    @all_puppies = Hash.new(0)
  end

  def add_puppy(puppy)
    if @all_puppies.has_key?(puppy.breed)
      @all_puppies[puppy.breed] << puppy
    else
      @all_puppies[puppy.breed] = [puppy]
    end
    return @all_puppies[puppy.breed]
  end

  def list_puppies(breed)
    @all_puppies[breed]
  end
  # puts a request object into the proper array using its status
  def add_request(request)
    @all_requests << request
    # if @requests_by_status.has_key?(request.status)
    #   @requests_by_status[request.status] << request
    # else
    #   @requests_by_status[request.status] = [request]
    # end
    # return @all_requests
    if self.check_breed(request.breed) == true
      request.pending
    elsif self.check_breed(request.breed) == false
      request.hold
    end
  end

  def set_breed_price(breed, price)
    @breed_prices[breed] = price
  end

  def return_breed_price(breed)
    @breed_prices[breed]
  end

  def list_requests(status)
    @all_requests.select do |elem|
      elem.status == status
    end
  end
  # This update method is for another funday!
  # def update
  #   @requests_by_status.each do |status_key, arr_of_matching_requests|
  #     arr_of_matching_requests.each do |req_object_elem|
  #       # check among the array to see if the request object's current
  #       # status matches the key that is pointing to the hash it's in.
  #       if req_object_elem.status != 
  #         # pop it out

  #         # put it in the right one
  #       end
  #     end
  #   # iterate through @requests_by_status
  #   # and pop them if their status is incorrect
  #   # then moving them to the right one.

  def check_breed(breed)
    # Nick says: don't make yo code smelly
    # !kennel.list_puppies(breed).empty?
    # check if breed key exists
    if @all_puppies.has_key?(breed) == true
    # if is does, check if array is empty or not
      !@all_puppies[breed].empty?
    #  if not, return false
    else
      false
    end
  end

end



















