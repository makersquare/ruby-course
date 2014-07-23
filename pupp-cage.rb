require "./puppy.rb"

module PuppCage

  PUPPY_LIST = Hash.new()  #Allows user to sort puppy objects and keys in hash with breed as key
  REQUEST_LIST = Hash.new() #Stores requests in a hash by phone_number=>request object

  def PuppCage.add_puppy(*puppy)
    # Puppy.new(breed:breed, cost:PUPPY_LIST[breed][:cost], age:0)
    puppy.each do |pupp| 
      if PuppCage.breed_contains_pupps?(pupp)
        PUPPY_LIST[pupp.breed][:puppies] << pupp
      else
        PUPPY_LIST[pupp.breed][:puppies] = [pupp]
      end
    end
  end

  def PuppCage.remove_puppy(puppy)
    PUPPY_LIST[puppy.breed][:puppies].delete(puppy)
  end

  def PuppCage.add_request(request)
    REQUEST_LIST<< request
  end

  def PuppCage.remove_request(request)
    REQUEST_LIST.delete(request)
  end

  def PuppCage.alter_breed_price(breed, cost=0)
    
    if PuppCage.breed_type_exists?(breed)
      PUPPY_LIST[breed][:cost]=cost
    else
      PUPPY_LIST[breed] = {cost:cost}
    end
  end

  def PuppCage.breed_contains_pupps?(pupp)
    if PuppCage.breed_type_exists?(pupp.breed)
      PUPPY_LIST[pupp.breed][:puppies].nil? ? false : true
    else
      PuppCage.alter_breed_price(pupp.breed)
      false
    end
  end

  def PuppCage.breed_type_exists?(breed)
    PUPPY_LIST[breed].nil? ? false : true
  end

end