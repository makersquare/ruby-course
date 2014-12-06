module PuppyBreeder::Repos
  class Puppies
    def initialize
      @puppies = {}
    end

    def create(params)
      name = params[:name]
      name_sym = name.to_sym
      breed = params[:breed]
      if(breed.class == PuppyBreeder::Breed)
        puppy = PuppyBreeder::Puppy.new(params)
        @puppies[name_sym] = puppy
      else
        breed_obj = PuppyBreeder.breeds_repo.find_by({name: breed}).first
        if !breed_obj
          breed_obj = PuppyBreeder::Breed.new({name: breed})
        end
        puppy = PuppyBreeder::Puppy.new({
          name: name,
          breed: breed_obj
        })
        @puppies[name_sym] = puppy
      end
    end

    def filter(type, spec)
      array = []
      @puppies.each do |key, puppy|
        if type == 'name' && puppy.name == spec
          array << puppy
        elsif type == 'breed' && puppy.breed.name == spec
          array << puppy
        elsif type == 'status' && puppy.status == spec
          array << puppy
        end
      end
      array
    end

    def find_by(params)
      name = params[:name]
      breed = params[:breed]
      status = params[:status]
      if breed.class == PuppyBreeder::Breed
        breed = breed.name
      end

      if name
        array = filter('name', name)
      elsif breed
        array = filter('breed', breed)
      elsif status
        array = filter('status', status)
      end
    end

    def update(params)
      name = params[:name].to_sym
      status = params[:status]
      @puppies[name].status = status
      @puppies[name]
    end
  end
end