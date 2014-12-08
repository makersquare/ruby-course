module PuppyBreeder::Repos
  class Breeds < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS breeds(
          id SERIAL PRIMARY KEY,
          name TEXT,
          price INT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS breeds CASCADE;
      SQL
      @db.exec(command)
    end

    def create(params)
      name = params[:name]
      price = params[:price]
      command = <<-SQL
        INSERT INTO breeds(name, price)
        VALUES ($1, $2)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, price]).first
      build_breed(result)
    end

    def find_by(params)
      name = params[:name]
      command = <<-SQL
        SELECT * FROM breeds WHERE name = $1;
      SQL
      @db.exec(command, [name]).map{ |result| build_breed(result)}
    end

    def update(params)
      name = params[:name]
      price = params[:price]
      command = <<-SQL
        UPDATE breeds SET price = $1 WHERE name = $2 RETURNING *;
      SQL
      result = @db.exec(command, [price, name]).first
      build_breed(result)
    end

    def build_breed(params)
      id = params['id'].to_i
      name = params['name']
      price = params['price'].to_i
      PuppyBreeder::Breed.new({
        id: id,
        name: name,
        price: price
      })
    end
  end
end