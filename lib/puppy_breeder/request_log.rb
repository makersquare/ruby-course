module PuppyBreeder
  class RequestLog
      @@request_log = []
      @@hold_log = []

    def self.add_request(request)
      # binding.pry
      if Inventory.puppies[request.breed] && Inventory.puppies[request.breed]["list"].length >= 1
        @@request_log.push(request)
    else
      @@hold_log.push(request)
    end
  end

    def self.review_pending
      #prints out a list of the information regarding the request
      pending = @@request_log.select{|request| request.status=="pending"}
    end

    def self.modify_request(request_id, decision) #takes the request id and 
      #whether the request is approved or denied
      found_request = @@request_log.select{|request| request.request_id == request_id}      
      found_request.first.status = decision
    end

    def self.check_hold(puppy)
      if @@hold_log.find{ |hold|  hold.breed == puppy.breed} #if the hold log includes the breed
        #find the first purchase request and return it. 
        hold = @@hold_log.find{ |hold|  hold.breed == puppy.breed}
        @@request_log.push(hold)
        @@hold_log.delete(hold)
      end
    end

    def self.view_completed
      completed_requests = @@request_log.select{|request| request.status !="pending"}
    end

    def self.request_log
      @@request_log
    end
    def self.hold_log
      @@hold_log
    end
  end
end