# we initialize the module here to use in our other files
module PuppyBreeder
  class Breeder 
    attr_accessor :name, :all_puppies


    def initialize(name)
      @all_puppies = { }
      @name = name
    end

    puts "Hello"

    def add_puppy(puppy)
      if !@all_puppies.has_key?(puppy.breed)
        @all_puppies[puppy.breed] = {
          :price => nil,
          :list => [puppy]
        }
      else
       @all_puppies[puppy.breed][:list].push(puppy)
     end
    end

    def all_puppies
      @all_puppies
    end

    def set_price(breed, price)
      @all_puppies[breed][:price] = price
    end
  end
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
