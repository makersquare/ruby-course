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
      @request
    end

    def view_completed
      #returns the completed log
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