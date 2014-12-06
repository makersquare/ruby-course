module PuppyBreeder
  class Breeder
    attr_reader :name, :puppies, :requests

    def initialize(params)
      @name = params[:name]
      @breeds = PuppyBreeder.breeds_repo
      @puppies = PuppyBreeder.puppies_repo
      @requests = PuppyBreeder.requests_repo
    end

    def create_request(params)
      @requests.create(params)
    end

    def add_puppy(params)
      @puppies.create(params)
    end

    def add_breed(params)
      @breeds.create(params)
    end

    def set_breed_price(params)
      @breeds.update(params)
    end

    def complete_request(params)
      params[:status] = 'completed'
      puppy_params = {
        name: params[:puppy].name,
        status: 'sold'
      }
      @puppies.update(puppy_params)
      @requests.update(params)
    end

    def get_requests(params = {})
      @requests.find_by(params)
    end

    def get_puppies(params = {})
      @puppies.find_by(params)
    end
  end
end