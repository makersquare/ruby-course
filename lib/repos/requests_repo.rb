module PuppyBreeder::Repos
  class Requests
    def initialize
      @requests = {}
    end

    def create(params)
      customer = params[:customer]
      key = customer.to_sym
      request = PuppyBreeder::PurchaseRequest.new(params)
      @requests[key] = request
    end

    def update(params)
      customer = params[:customer].to_sym
      status = params[:status]
      puppy = params[:puppy]
      @requests[customer].status = status
      @requests[customer].puppy = puppy
      @requests[customer]
    end

    def find_by(params = {})
      customer = params[:customer]
      status = params[:status]
      if customer
        requests = filter('customer', customer)
      elsif status
        requests = filter('status', status)
      else
        requests = filter('all')
      end
    end

    def filter(type, spec = '')
      array = []
      @requests.each do |key, request|
        if type == 'customer' && request.customer == spec
          array << request
        elsif type == 'status' && request.status == spec
          array << request
        elsif type == 'all'
          array << request
        end
      end
      array
    end
  end
end