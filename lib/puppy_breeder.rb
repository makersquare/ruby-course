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

  # def self.pending_requests
  #   PuppyBreeder::Data.allrequests.each do |x|
  #     if x.status == 'pending'
  #       puts "Pending Requests:"
  #       puts "#Request No. #{x.id}"
  #     end
  #     "There are no pending requests."
  #   end
  # end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
require_relative 'puppy_breeder/data.rb'
