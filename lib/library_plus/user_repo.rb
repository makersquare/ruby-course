# Library::UserRepo.all(db)
#Library::BookRepo.all(db) 

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

    #Libary::UserRepo.save(db, {'id' => "1"})
    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
      else
        # TODO: Insert SQL statement
      end
    end

    def self.destroy(db, user_data)
      # TODO: Delete SQL statement
    end

  end
end
