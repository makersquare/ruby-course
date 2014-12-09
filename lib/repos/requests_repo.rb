module PuppyBreeder::Repos
  class Requests < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS requests(
          id SERIAL PRIMARY KEY,
          customer TEXT,
          breed TEXT,
          status TEXT,
          puppy_id INT REFERENCES puppies(id)
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS requests;
      SQL
      @db.exec(command)
    end

    def create(params)
      customer = params[:customer]
      breed_id = get_breed_id(params[:breed])
      status = params[:status] || 'pending'
      command = <<-SQL
        INSERT INTO requests(customer, breed, status)
        VALUES ($1, $2, $3)
        RETURNING *;
      SQL
      result = @db.exec(command, [customer, breed_id, status]).first
      build_request(result)
    end

    def get_breed_id(breed)
      breed = breed.name if breed.class == PuppyBreeder::Breed
      breed_obj = PuppyBreeder.breeds_repo.find_by({name: breed}).first
      breed_obj = PuppyBreeder.breeds_repo.create({
        breed: breed
      }) if !breed_obj
      breed_obj.id
    end

    def update(params)
      customer = params[:customer]
      status = params[:status]
      puppy = params[:puppy]
      puppy_id = get_puppy_id(puppy) if puppy
      command = <<-SQL
        UPDATE requests
      SQL

      if puppy && status
        spec = <<-SQL
          SET status = $1, puppy_id = $2 WHERE customer = $3 RETURNING *;
        SQL
        result = @db.exec(command + spec, [status, puppy_id, customer]).first
      elsif puppy
        spec = <<-SQL
          SET puppy_id = $1 WHERE customer = $2 RETURNING *;
        SQL
        result = @db.exec(command + spec, [puppy_id, customer]).first
      elsif status
        spec = <<-SQL
          SET status = $1 WHERE customer = $2 RETURNING *;
        SQL
        result = @db.exec(command + spec, [status, customer]).first
      end
      build_request(result)
    end

    def get_puppy_id(puppy)
      puppy = puppy.name if puppy.class == PuppyBreeder::Puppy
      PuppyBreeder.puppies_repo.find_by({name: puppy}).first.id
    end

    def find_by(params = {})
      customer = params[:customer]
      status = params[:status]
      command = <<-SQL
        SELECT * FROM requests
      SQL

      if customer
        spec = <<-SQL
          WHERE customer = $1;
        SQL
        results = @db.exec(command + spec, [customer])
      elsif status
        spec = <<-SQL
          WHERE status = $1;
        SQL
        results = @db.exec(command + spec, [status])
      else
        results = @db.exec(command)
      end
      results.map{ |result| build_request(result) }
    end

    def build_request(params)
      id = params['id'].to_i
      customer = params['customer']
      breed = PuppyBreeder.breeds_repo.find(params['breed'])
      status = params['status']
      puppy = params['puppy'] ? params['puppy'].to_i : nil
      PuppyBreeder::PurchaseRequest.new({
        id: id,
        customer: customer,
        breed: breed,
        status: status,
        puppy: puppy
      })
    end
  end
end