module Library
  class BookRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
      # TODO: Insert SQL statement
      db.exec("SELECT * FROM books WHERE id = #{book_id};").first
    end

    def self.save(db, book_data)
      if book_data['id']
        # TODO: Update SQL statement
        db.exec("UPDATE books SET name = '#{book_data['name']}', author = '#{book_data['author']}' WHERE id = #{book_data['id']};")
      else
        # TODO: Insert SQL statement
        db.exec("INSERT INTO books (name, author, checked_status) VALUES ('#{book_data['name']}', '#{book_data['author']}', FALSE);")
      end
      db.exec("SELECT * FROM books;").first
    end

    def self.destroy(db, book_id)
      # TODO: Delete SQL statement
    end

  end
end
