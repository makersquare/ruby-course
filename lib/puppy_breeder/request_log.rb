module PuppyBreeder
  class RequestLog
    attr_reader :request_log, :pending
    def initialize
      @request_log = []
    end

    def add_request(request)
      @request_log.push(request)
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

    def view_all
      #return all requests in the log including pending, rejected,
      #and approved

    end
    def view_rejected
      #return only rejected requests from the log
    end
    def purge_log
      #erase the contents of the log or possibly do this for only 
      #rejected items
    end
  end
end