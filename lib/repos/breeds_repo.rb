module PuppyBreeder::Repos
  class Breeds
    def initialize
      @breeds = {}
    end

    def create(params)
      breed = PuppyBreeder::Breed.new(params)
      key = breed.name.gsub(' ', '_').to_sym
      @breeds[key] = breed
    end

    def find_by(params)
      if(params[:name])
        key = params[:name].to_sym
        [@breeds[key]]
      end
    end

    def update(params)
      key = params[:name].to_sym
      price = params[:price]
      @breeds[key].price = price
      @breeds[key]
    end
  end
end