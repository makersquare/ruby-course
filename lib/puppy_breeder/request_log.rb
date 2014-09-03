module PuppyBreeder
  class RequestLog
    attr_reader :request_log, :pending
    def initialize
      @request_log = []
    end

    def add_request(request)
      @request_log.push(request)
      #add code that if the breed requested does not match
      #any dogs in the kennel then the request is put into
      #a hold queue LOOK AT ME OVER HERE I AM CODE THAT NEEDS
      #TO BE IMPLEMENTED
    end

    def review_pending
      #prints out a list of the information regarding the request
      pending = @request_log.select{|request| request.status=="pending"}
    end

    def modify_request(request_id, decision) #takes the request id and 
      #whether the request is approved or denied
      found_request = @request_log.select{|request| request.request_id == request_id}      
      found_request.first.status = decision
    end

    def view_completed
      completed_requests = @request_log.select{|request| request.status !="pending"}
    end
  end
end