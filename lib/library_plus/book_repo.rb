module Library
  class BookRepo
  # TODO
    def self.all(db)

      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
    # TODO: Insert SQL statement

      result = db.exec("SELECT * FROM books WHERE id = $1", [book_id])
      result.entries[0]


    end

    def self.save(db, book_data)
      if book_data['id']
        # TODO: Update SQL statement
        title = book_data['title']
        author = book_data['author']
        id = book_data['id']
        db.exec("UPDATE books SET title = $1, author = $2 WHERE id = $3", [title, author, id])
        new_data = Library::BookRepo.find(db, id)
        new_data

      else
        # TODO: Insert SQL statement
        title = book_data['title']
        author = book_data['author']
        returned = db.exec("INSERT into books (title, author) VALUES ($1, $2) returning id", [title, author])
        # new_data = Library::UserRepo.find(db, id)
        book_data['id'] = returned.entries[0]['id']
        # require 'pry-byebug'; binding.pry
        book_data
      end
    end

    def self.checkout_status(db, book_id)
      status = db.exec("SELECT status FROM checkouts where book_id = $1", [book_id]).to_a
      if status.entries[0] == nil
        status = "available"
      else
        status[0]['status']
      end
    end

    def self.checkout(db, book_id, user_name)
      response = db.exec("SELECT status FROM checkouts where book_id = $1", [book_id]).to_a
      if response.entries[0] == nil      
        user_id = db.exec("SELECT id FROM users where name = $1", [user_name]).to_a[0]['id']
        status = db.exec("INSERT INTO checkouts (user_id, book_id, status) VALUES ($1, $2, $3) returning status", [user_id, book_id, "checked_out"]).to_a[0]['status']
        # response = "This book has not been checked out."
        status
      elsif response.entries[0]['status'] == "available"
        status = db.exec("UPDATE checkouts SET status = $1 WHERE book_id = $2 returning status", ["checked_out", book_id]).to_a[0]['status']
        status
      else
        status = "This book is currently checked out, please select another."
      end
    end


 

  end
end
