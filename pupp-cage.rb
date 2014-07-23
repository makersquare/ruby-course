require "./puppy.rb"
require "./request.rb"

module PuppCage

  PUPPY_LIST = Hash.new()  #Allows user to sort puppy objects and keys in hash with breed as key
  REQUEST_LIST = Hash.new() #Stores requests in a hash by phone_number=>request object

  def PuppCage.add_puppy(*puppy)
    # Puppy.new(breed:breed, cost:PUPPY_LIST[breed][:cost], age:0)
    puppy.each do |pupp| 
      if PUPPY_LIST[pupp.breed].nil? || PUPPY_LIST[pupp.breed][:puppies].nil?
        PuppCage.alter_breed_price(pupp.breed)
        PUPPY_LIST[pupp.breed][:puppies] = [pupp]
      else
        PUPPY_LIST[pupp.breed][:puppies] << pupp
      end
    end
  end

  def PuppCage.remove_puppy(puppy)
    PUPPY_LIST[puppy.breed][:puppies].delete(puppy)
  end

  def PuppCage.add_request(*args)
    # if args[0].is_a String 
    #   info = {
    #     cust_phone_number:args[0],
    #     cost:args[1]
    #   }
    # else
    #   info = {
    #    cust_phone_number:args[0],
    #     breed:args[1]
    #   }
    # end

    str_arg = args.map!(&:to_s).join
    info = {
      breed:str_arg[/[a-zA-Z]+/],
      cust_phone_number:str_arg[/^\d+/].to_i
    }

    if PUPPY_LIST[info[:breed]].nil? then return end
    request=Request.new(info)
    REQUEST_LIST[request.cust_phone_number]=request
  end

  def PuppCage.remove_request(cust_phone_number)
    REQUEST_LIST.delete(cust_phone_number)
  end

  def PuppCage.alter_breed_price(breed, cost=0)    
    if PUPPY_LIST[breed].nil?
      PUPPY_LIST[breed] = {cost:cost}
    else
      PUPPY_LIST[breed][:cost]=cost
    end
  end

end