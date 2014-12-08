module Library
  class BookRepo

    def self.index(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.show(db, book_id)
      # TODO: Insert SQL statement
      res =  db.exec_params("SELECT * FROM books WHERE id = $1",[book_id])
      return res.first
    end

    def self.show_checkouts(db, book_id)
      # TODO: Insert SQL statement
      res =  db.exec_params("SELECT * FROM checkouts WHERE book_id = $1",[book_id])
      return res.first
    end

    def self.checkout(db, book_id, user_id)
      exist =  db.exec_params("SELECT * FROM checkouts WHERE book_id = $1",[book_id])
      if (exist.first == nil)
        db.exec_params("INSERT INTO checkouts (book_id, user_id) VALUES ($1, $2)", [book_id, user_id])
        return 'added'
      else
        db.exec_params("UPDATE checkouts SET status = 'checked_out' WHERE book_id = $1", [book_id])
        return 'added'
      end
    end

    def self.create(db, book_data)
      # TODO: Insert SQL statement
      db.exec_params("INSERT INTO books (title, author) VALUES ($1, $2)",[ book_data['title'], book_data['author'] ])
      res =  db.exec_params("SELECT * FROM books WHERE title = $1",[book_data['title']])
      return res.first
    end

    def self.destroy(db, book_id)
      # TODO: Delete SQL statement
      db.exec_params("DELETE FROM books WHERE id= $1 ",[book_id])
    end

  end
end