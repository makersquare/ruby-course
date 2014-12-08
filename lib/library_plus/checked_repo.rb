module Library
  class CheckedRepo

    def self.checkout_book(db, book_data)
        # TODO: Update SQL statement
        db.exec("INSERT INTO checked_books (user_id, book_id) VALUES ('#{book_data['user_id']}', '#{book_data['book_id']}');")
        db.exec("UPDATE books SET checked_status = TRUE WHERE id = #{book_data['book_id']};")
    end

    def self.return_book(db, book_data)
        db.exec("UPDATE checked_books SET checked_status = FALSE WHERE book_id = #{book_data['id']};")
        db.exec("UPDATE books SET checked_status = FALSE WHERE id = #{book_data['id']};")
    end

    def self.all(db)
         db.exec("SELECT * FROM books INNER JOIN checked_books ON checked_books.book_id = books.id;")
    end

    def self.lookup_status(db, book_data)
        db.exec("SELECT checked_status FROM checked_books INNER JOIN books ON (checked_books.book_id = books.id) WHERE book_id = #{book_data['book_id']};")
    end
  end
end
