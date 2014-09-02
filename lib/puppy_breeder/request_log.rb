module PuppyBreeder
  class RequestLog
    attr_reader :request_log
    def initialize
      @request_log = []
    end

    def add_request(request)
      @request_log.push(request)
    end

    def review_requests
      #find and return the requests that have status of pending
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