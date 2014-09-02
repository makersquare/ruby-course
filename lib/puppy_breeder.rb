# we initialize the module here to use in our other files
module PuppyBreeder
  class Breeder
    attr_accessor :puppies_available
    
    @@puppies_available = Hash.new(0)
  end
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
