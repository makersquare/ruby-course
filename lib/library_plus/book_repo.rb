module Library
  class BookRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_data)
      # TODO: Insert SQL statement
    end

    def self.save(db, book_data)
      if book_data[:id]
        # TODO: Update SQL statement
      else
          title = book_data[:title]
          author = book_data[:author]
        db.exec("INSERT INTO books (title, author) VALUES ('#{title}', '#{author}')")
        r = db.exec("SELECT id, title FROM books ORDER BY id DESC LIMIT 1").to_a
        return r[0]
      end
    end

    def self.destroy(db, book_data)
      if(book_data[:id])
        db.exec("DELETE FROM books WHERE  id = #{book_data[:id]}")
      else
        db.exec("DELETE FROM books WHERE  title = #{book_data[:title]}")
      end
    end
  end
end
# TODO
