module PuppyBreeder::Repos
  class Puppies < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS puppies(
          id SERIAL PRIMARY KEY,
          name TEXT,
          breed INT REFERENCES breeds(id),
          status TEXT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS puppies CASCADE;
      SQL
      @db.exec(command)
    end

    def create(params)
      name = params[:name]
      breed = params[:breed]
      id = get_breed_id(breed)
      status = params[:status] || 'available'
      command = <<-SQL
        INSERT INTO puppies(name, breed, status)
        VALUES ($1, $2, $3)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, id, status]).first
      build_puppy(result)
    end

    def get_breed_id(breed)
      breed = breed.name if breed.class == PuppyBreeder::Breed
      breed_obj = PuppyBreeder.breeds_repo.find_by({
        name: breed
      }).first
      if !breed_obj
        breed_obj = PuppyBreeder.breeds_repo.create({
          name: breed
        })
      end
      breed_obj.id
    end

    # def filter(type, spec = '')
    #   array = []
    #   @puppies.each do |key, puppy|
    #     if type == 'name' && puppy.name == spec
    #       array << puppy
    #     elsif type == 'breed' && puppy.breed.name == spec
    #       array << puppy
    #     elsif type == 'status' && puppy.status == spec
    #       array << puppy
    #     elsif type == 'all'
    #       array << puppy
    #     end
    #   end
    #   array
    # end

    def filter(type, spec= '')
      case type
      when 'name'
      when 'breed'
      when 'status'
      when 'all'
      end
    end

    def find_by(params = {})
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
      else
        array = filter('all')
      end
    end

    def update(params)
      name = params[:name]
      status = params[:status]
      command = <<-SQL
        UPDATE puppies SET status = $1 WHERE name = $2;
      SQL
      @db.exec(command, [name, status])
        .map{ |result| build_puppy(result) }.first
    end

    def build_puppy(params)
      id = params['id'].to_i
      name = params['name']
      breed = PuppyBreeder.breeds_repo.find(params['breed'])
      status = params['status']
      PuppyBreeder::Puppy.new(
        id: id,
        name: name,
        breed: breed,
        status: status
      )
    end
  end
end