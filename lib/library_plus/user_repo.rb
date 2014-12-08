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

    ## create, update
    ## Library::UserRepo.save(db, {'name' => "Alice"})
    ### This is how you call this (to create new one)
    ## Library::UserRepo.save(db, {'id' => 1, name' => "Alice2"})
    ### This will update record, instead of creating a new one

    def self.save(db, user_data)
      if user_data['id']
        # TODO: Update SQL statement
      else
        # TODO: Insert SQL statement
      end
    end

<<<<<<< HEAD
    def self.destroy(db, user_id)  ##was user_data, changed by GG##
=======
    def self.destroy(db, user_id)
>>>>>>> 402ab5712c8e8441c5d730325560df6d619114e8
      # TODO: Delete SQL statement
    end

  end
end
