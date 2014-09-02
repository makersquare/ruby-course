#Customer needs to be able to make a purchase request
#Breeder: manually input purchase request (if a customer sent in their order via fax, letter, or verbal agreement)
#Breeder: add new puppies for sale
#Breeder: review and accept new purchase requests
#Breeder: view all completed purchase orders

# we initialize the module here to use in our other files
module PuppyBreeder

  def self.add_breed(name, cost)
    PuppyBreeder::Data.cost[name] = cost
  end

  def self.complete_request(id, dog)
    if request_pending? && dog_available?
      


      end
    end
  end

  def self.dog_available?(breed)
    PuppyBreeder::Data.allpuppies.each do |x|
      if x.breed == breed && x.status = 'available'
      end
    end
  end

  def request_pending?(id)
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
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
require_relative 'puppy_breeder/data.rb'
