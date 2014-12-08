# Library ::UserRepo  <-- how to reference this class
# This is a user class under the Library module
# Library::UserRepo.all(db)
# Library::BookRepo.all(db)

module Library
  class UserRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM users").to_a
    end

    def self.find(db, user_id)
      # TODO: Insert SQL statement
    end
        # Use Create if !exists and Update if does
        # TODO: Update SQL statement
        # Library::UserRepo.save(db, { :name => "Alice" })

    def self.save(db, user_data)
      if user_data['id']

        #
      else
      db.exec("INSERT INTO users (name) VALUES ($1)", [user_data[:name]])  
      results = db.exec("SELECT * FROM users")
      results
      end
    end

    def self.destroy(db, user_data)
      # TODO: Delete SQL statement
    end

  end
end
