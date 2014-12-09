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

    def find_by(params = {})
      name = params[:name]
      breed = params[:breed]
      breed_id = get_breed_id(breed)
      status = params[:status]
      command = <<-SQL
        SELECT * FROM puppies 
      SQL

      if name
        spec = <<-SQL
          WHERE name = $1;
        SQL
        results = @db.exec(command + spec, [name])
      elsif breed
        spec = <<-SQL
          WHERE breed = $1;
        SQL
        results = @db.exec(command + spec, [breed_id])
      elsif status
        spec = <<-SQL
          WHERE status = $1;
        SQL
        results = @db.exec(command + spec, [status])
      else
        results = @db.exec(command)
      end
      results.map{ |result| build_puppy(result) }
    end

    def update(params)
      name = params[:name]
      status = params[:status]
      command = <<-SQL
        UPDATE puppies SET status = $1 WHERE name = $2 RETURNING *;
      SQL
      @db.exec(command, [status, name])
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