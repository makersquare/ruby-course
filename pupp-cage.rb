module PuppCage

    @puppy_list = Hash.new([])  #Allows user to sort puppy objects in hash with breed as key
    @request_list = Hash.new() #Stores requests in a hash by phone_number=>request object
    @breed_price = Hash.new()

    def add_puppy(breed)
      puppy.new(breed:breed, cost:@breed_price[breed], age:0)
      @puppy_list[puppy.breed]<<puppy
    end

    def remove_puppy(puppy)
      @puppy_list[puppy.breed].delete(puppy)
    end

    def add_request(request)
      @request_list << request
    end

    def remove_request(request)
      @request_list.delete(request)
    end

    def alter_breed_price(breed, cost)
      @breed_price[breed]=cost
    end

end