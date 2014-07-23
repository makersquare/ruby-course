require "./puppy.rb"
require "./request.rb"

module PuppCage

  PUPPY_LIST = Hash.new()  #Allows user to sort puppy objects and keys in hash with breed as key
  REQUEST_LIST = [] #Stores requests in a hash by phone_number=>request object

  def PuppCage.add_puppy(*puppy)
    puppy.each do |pupp| 

      breed = pupp.breed

      if PUPPY_LIST[breed].nil?
        PuppCage.alter_breed_price(breed)
        PUPPY_LIST[breed][:puppies] = [pupp]
        PuppCage.check_held_requests(breed)
      elsif PUPPY_LIST[breed][:puppies].nil?
        PUPPY_LIST[breed][:puppies] = [pupp]
        PuppCage.check_held_requests(breed)
      else        
        if PUPPY_LIST[breed][:puppies].size == 0 
          PuppCage.check_held_requests(breed)
        end
        PUPPY_LIST[breed][:puppies] << pupp
      end
    end
  end

  def PuppCage.remove_puppy(puppy)
    PUPPY_LIST[puppy.breed][:puppies].delete(puppy)
  end

  def PuppCage.add_request(*args)
    str_arg = args.map!(&:to_s).join
    info = {
      breed:str_arg[/[a-zA-Z]+/],
      cust_phone_number:str_arg[/^\d+/].to_i
    }

    if PUPPY_LIST[info[:breed]].nil? then PuppCage.alter_breed_price(info[:breed]) end
    if PUPPY_LIST[info[:breed]][:puppies].nil? || PUPPY_LIST[info[:breed]][:puppies]==0
      info[:status]=:hold 
    end
 
    request=Request.new(info)
    REQUEST_LIST << request
    request
  end

  def PuppCage.remove_request(req)
      REQUEST_LIST.delete(req) 
  end

  def PuppCage.alter_breed_price(breed, cost=0)    
    if PUPPY_LIST[breed].nil?
      PUPPY_LIST[breed] = {cost:cost}
    else
      PUPPY_LIST[breed][:cost]=cost
    end
  end

  def PuppCage.check_held_requests(breed)
    if REQUEST_LIST.nil? then return end
    REQUEST_LIST.each do |cust| 
      if cust.breed == breed then cust.status_to_pending end
    end
  end

  def PuppCage.pending_requests
    REQUEST_LIST.each{|x| puts x.status}
    pending_list = REQUEST_LIST.select{ |x| x.status==:pending }
    pending_list
  end

  def PuppCage.request_accept(request)
    request.status_to_accepted
  end

  def PuppCage.request_reject(request)
    request.status_to_hold
  end

end



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