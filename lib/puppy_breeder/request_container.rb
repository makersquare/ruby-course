module PuppyBreeder

class RequestContainer

@@requests = {:doberman => [obj1,obj2],
  :pitbull => [asdf,asdf,asdf]

  def self.requests
    @@requests
  end

  def self.save_request(purchaserequest)
  




  if @@requests.keys.include?(purchaserequest.breed) 
    return @@requests[purchaserequest.breed][:list] << purchaserequest
    else
      @@requests[purchaserequest.breed] = [purchaserequest]
        
    
  else


  end

  def self.show_all_requests
    @@requests
  end

  def self.show_accepted_requests
    @@requests.select { |r| r.status == 'accepted' }
  end

  def self.show_hold_requests
    @@requests.select { |r| r.status == 'hold'}
  end

end
end