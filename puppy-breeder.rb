# user_breed_request = get.chomp("Please enter the breed you'd like")

class PurchaseRequest
  attr_accessor :name, :breed, :status
  
  def initialize(name, breed)
  @name = name
  @breed = breed
  @status = :pending 
  end

  def pending?
      @status == :pending
  end 
  
  def onhold?
      @status == :onhold
  end

  def accepted?
      @status == :accepted
  end          
end 

class Puppy
  attr_accessor :name, :breed, :age
  def initialize(breed, age, name)
    @breed = breed
    @name = name 
    @age = age 
  end
end 


class PuppyContainer
  # attr_accessor :container
  # def initialize
  #     @container = {}
  # end
  @container = {}
  def self.add_puppy_to_puppy_container(puppy)
    if @container.has_key?(puppy.breed)
          @container[puppy.breed][:list] << puppy
    else
      @container[puppy.breed] = {:price => :unknown, :list => [puppy]}
    end
    @container
  end

  def self.container
    @container
  end

end

class RequestContainer
  attr_accessor :container
      @container = []
  def self.container
    @container
  end
  def self.add_request_to_request_container(request)
    @container << request
    x = PuppyContainer.container
    if x.has_key?(request.breed) && !x[request.breed][:list].empty?
      request.status = :pending
    elsif x.has_key?(request.breed) && x[request.breed][:list].empty?
      request.status = :onhold
    else
      request.status = :onhold
    end
    @container
  end
  
  def self.accept_request(request)
      request.status = :accepted
  end     
  def self.request_active     
      @container.select{|r| r.pending? || r.accepted?}
  end  
  def self.request_on_hold
      @container.select{|r| r.onhold?}
  end

end 


# @container = {
#   :boxer => {
#     :price => 4000,
#     :list => [pup1, pup2]
#   },
#   :pit =>  {
#     :price => 4000,
#     :list => [pup3, pup4]
#   },
# }

  