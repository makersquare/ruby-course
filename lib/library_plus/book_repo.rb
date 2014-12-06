module Library
  class BookRepo
    def self.all
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
      db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
    end

    def self.check_out(db, book_id, user_id)
      book = db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
      if book['status'] == 'available'
        # Update Status to 'checked-out'
        db.exec("UPDATE books SET status = 'checked_out' WHERE id = #{book_id}")
        db.exec("UPDATE books SET user_id = '#{user_id}' WHERE id = #{book_id}")
      end
      find(db, book_id)
    end

    def self.check_in(db, book_id)
      book = db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
      if book['status'] == 'checked_out'
        # Update Status to 'available'
        db.exec("UPDATE books SET status = 'available' WHERE id = #{book_id}")
        db.exec("UPDATE books SET user_id = 'nil' WHERE id = #{book_id}")
      end
      find(db, book_id)
    end

    def self.save(db, book_data)
      if book_data['id']
        # Update Name
        db.exec("UPDATE books SET title = '#{book_data['title']}', author = '#{book_data['author']}' WHERE id = #{book_data['id']}")
      else
        # Enter Name and Unique ID gets assigned automatically
        db.exec("INSERT INTO books (title, author) VALUES ('#{book_data['name']}', '#{book_data['author']}')")
      end
      get_books(db, book_data).last
    end

    def self.destroy(db, book_id)
      db.exec("DELETE FROM books WHERE id = #{book_id}")
    end

    def self.get_books(db, book_data)
      if book_data['id']
        db.exec("SELECT * FROM books WHERE id = #{book_data['id']}").entries
      elsif book_data['title'] && book_data['author']
        db.exec("SELECT * FROM books WHERE title = '#{book_data['title']}', author = '#{book_data['author']}'").entries
      elsif book_data['title'] 
        db.exec("SELECT * FROM books WHERE title = '#{book_data['title']}'").entries
      elsif book_data['author'] 
        db.exec("SELECT * FROM books WHERE title = '#{book_data['author']}'").entries 
      end
    end

    def self.get_status(db, book_id)
      db.exec("SELECT * FROM books WHERE id = #{book_data['id']}").entries.last['status']
    end

  end
end
