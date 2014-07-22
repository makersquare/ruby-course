require "./puppy.rb"

module PuppCage

    PUPPY_LIST = Hash.new({cost:0, puppies:[]})  #Allows user to sort puppy objects and keys in hash with breed as key
    REQUEST_LIST = Hash.new() #Stores requests in a hash by phone_number=>request object

    def PuppCage.add_puppy(*puppy)
      # Puppy.new(breed:breed, cost:PUPPY_LIST[breed][:cost], age:0)
      puppy.each{ |pupp| PUPPY_LIST[pupp.breed][:puppies]  << pupp }
    end

    def PuppCage.remove_puppy(puppy)
      PUPPY_LIST[puppy.breed].delete(puppy)
    end

    def PuppCage.add_request(request)
      REQUEST_LIST<< request
    end

    def PuppCage.remove_request(request)
      REQUEST_LIST.delete(request)
    end

    def PuppCage.alter_breed_price(breed, cost)
      PUPPY_LIST[breed][:cost]=cost
    end

end