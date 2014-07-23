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

  def accept
    @status = :accepted
  end

  def complete
    @status = :complete
  end
end

class Kennel

  attr_accessor :name, :owner, :all_puppies
  # keeps track of all puppies by breeds. breeds are symbols pointing to an array of puppy objects that have the attribute symbol that matches their breed

  def initialize(name, owner)
    @name = name
    @owner = owner
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
    find_breed = breed.to_sym
    @all_puppies[find_breed].map do |x|
      x.name
    end
  end
end

class Store

  attr_reader :name, :owner, :requests_by_status, :breed_prices, :all_requests

  def initialize(name, owner)
    @name = name
    @owner = owner
    # @requests_by_status = Hash.new(0)
    @all_requests = Array.new(0)
    @breed_prices = Hash.new(0)
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
  end

  def set_breed_price(breed, price)
    @breed_prices[breed] = price
  end

  def list_requests(status)
    list = []
    @all_requests.each do |elem|
      list << elem if elem.status == status
    end
    return list
  end
  # This update method is for another day!
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
end



















