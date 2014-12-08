module Library
  class BookRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
      result = db.exec_params("SELECT books.*, checkout.status FROM books LEFT JOIN checkout ON books.id = checkout.book_id WHERE books.id = $1", [book_id])
      return result.first
    end

    def self.create(db, book_data)
      book_id = db.exec_params("INSERT INTO books (title, author) VALUES ($1, $2) returning id", [book_data['title'], book_data['author']])
      puts book_id
      # db.exec_params("INSERT INTO checkout (book_id) VALUES ($1)", [book_id])
      result = db.exec("SELECT * FROM books WHERE title = $1", [book_data['title']])
      return result.first
    end

    def self.destroy(db, book_id)
      # TODO: Delete SQL statement
    end

    def self.checkout(db, book_id, user_id)
      result = db.exec_params("SELECT status FROM checkout WHERE book_id = $1", [book_id.to_i])
      if (result == nil)
        db.exec_params("INSERT INTO checkout (book_id) VALUES ($1)", [book_id])
        db.exec_params("UPDATE checkout SET status = 'checked_out', user_id = $1 WHERE book_id = $2", [user_id, book_id.to_i])
        result = db.exec_params("SELECT books.*, checkout.status FROM books LEFT JOIN checkout ON books.id = checkout.book_id WHERE books.id = $1", [book_id.to_i])
        return result.first
      elsif result == 'checked_out'
        return false
      else
        db.exec_params("UPDATE checkout SET status = 'checked_out' WHERE book_id = $1", [book_id.to_i])
        db.exec_params("UPDATE checkout SET user_id = $1 WHERE book_id = $2", [user_id, book_id.to_i])
        result = db.exec_params("SELECT books.*, checkout.status FROM books LEFT JOIN checkout ON books.id = checkout.book_id WHERE books.id = $1", [book_id.to_i])
        return result.first
      end
    end

  end
end
