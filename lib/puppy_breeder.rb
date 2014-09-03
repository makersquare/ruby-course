#Customer needs to be able to make a purchase request
#Breeder: manually input purchase request (if a customer sent in their order via fax, letter, or verbal agreement)
#Breeder: add new puppies for sale
#Breeder: review and accept new purchase requests
#Breeder: view all completed purchase orders

# we initialize the module here to use in our other files

#How do we structure this
module PuppyBreeder

  def self.add_breed(name, cost)
    PuppyBreeder::Data.cost[name] = cost
  end

  def self.complete_request(id)
    request = PuppyBreeder::Data.allrequests.select { |y| y.id == id }.first
    puppy = PuppyBreeder::Data.allpuppies.select { |x| x.breed == request.breed }.first
    if request_pending?(id) && dog_available?(request.breed)
      puppy.status = 'adopted'
      request.puppy = puppy
      request.status = 'completed'
    elsif request_pending?(id) && dog_available?(request.breed) == false
      request.status = "hold"
    end
  end


  def self.dog_available?(breed)
    PuppyBreeder::Data.allpuppies.each do |x|
      if x.breed == breed && x.status = 'available'
        return true
      else
        return false
      end
    end
  end

  def self.request_pending?(id)
    PuppyBreeder::Data.allrequests.each do |x|
      if x.id == id && x.status = 'pending'
      end
    end
  end

  def self.pending_requests
    PuppyBreeder::Data.allrequests.select {|x| x.status == 'pending'}
  end

  def self.completed_requests
    PuppyBreeder::Data.allrequests.select {|x| x.status == 'completed'}
  end

  def remove_hold(id)
    request = PuppyBreeder::Data.allrequests.select {|x| x.id == id }
    request.status = 'pending'
  end
end

  

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
require_relative 'puppy_breeder/data.rb'
