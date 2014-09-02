module PuppyBreeder
  class RequestLog
    attr_reader :request_log
    def initialize
      @request_log = []
    end

    def add_request(request)
      @request_log.push(request)
    end
  end
end