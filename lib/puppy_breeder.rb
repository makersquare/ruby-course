# we initialize the module here to use in our other files
module PuppyBreeder

    class Breeder
    attr_reader :name, :puppies, :price_list, :bank_account
    attr_accessor :purchase_requests

    def initialize(name)
      @name = name
      @bank_account = 0
      @puppies = []
      @purchase_requests = {}
      @price_list = {'Mut' => 50}
    end

    def new_puppy(puppy)
      price_assignment(puppy)
      @puppies << puppy
    end

    def update_price(update_breed, new_price)
      @price_list[update_breed] = new_price
      @puppies.each {|pup| pup.price = new_price if pup.breed == update_breed}
    end

    def pending(dog, customer)
      dog.status = "pending purchase by #{customer.name}"
      @purchase_requests[customer] = dog
    end

    def sell_dog(dog)
      status_arr = dog.status.split
      if status_arr.first == 'pending'
        @bank_account += dog.price
        dog.status = "sold to #{status_arr[3..-1].join(" ")}"
        @puppies.delete(dog)
      end
    end

    private
    
    def price_assignment(puppy)
      puppy.price = @price_list[puppy.breed]
    end


  end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'

