require 'pry-byebug'

module Library
  class BookRepo
    def self.all(db)
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
      db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
    end

    def self.checkout(db, book_id, user_id)
      book = db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
      if book['status'] == 'available'
        # Update Status to 'checked-out'
        db.exec("UPDATE books SET status = 'checked_out' WHERE id = #{book_id}")

        # Add book to checkout history table
        db.exec("INSERT INTO checkouts (book_id, user_id, status, checkout_date) VALUES (#{book_id}, #{user_id}, 'checked_out', '#{Time.now}')")
      end
      find(db, book_id)
    end

    def self.checkin(db, book_id)
      book = db.exec("SELECT * FROM books WHERE id = #{book_id}").entries.last
      if book['status'] == 'checked_out'

        # Update books table to 'available'
        db.exec("UPDATE books SET status = 'available' WHERE id = #{book_id}")

        # Update checkout table to 'returned'
        db.exec("UPDATE checkouts SET status = 'returned' WHERE book_id = #{book_id} AND status = 'checked_out'")
      end
      find(db, book_id)
    end

    def self.save(db, book_data)
      if book_data['id']
        # Update Title
        if book_data['title']
          db.exec("UPDATE books SET title = '#{book_data['title']}' WHERE id = #{book_data['id']}")
        end
        if book_data['author']
          db.exec("UPDATE books SET author = '#{book_data['author']}' WHERE id = #{book_data['id']}")
        end
      else
        # Enter Title and Unique ID gets assigned automatically
        db.exec("INSERT INTO books (title, author, status) VALUES ('#{book_data['title']}', '#{book_data['author']}', 'available')")
      end
      # puts get_users(db, user_data)
      get_books(db, book_data).last
    end

    def self.lose(db, book_id)
      # Update books table to 'available'
      db.exec("UPDATE checkouts SET status = 'lost' WHERE book_id = #{book_id} AND status = 'checked_out'")
      db.exec("UPDATE books SET status = 'lost' WHERE id = #{book_id}")
    end

    def self.get_books(db, book_data)
      if book_data['id']
        db.exec("SELECT * FROM books WHERE id = #{book_data['id']}").entries
      elsif book_data['title'] && book_data['author']
        db.exec("SELECT * FROM books WHERE title = '#{book_data['title']}' AND author = '#{book_data['author']}'").entries
      elsif book_data['title'] 
        db.exec("SELECT * FROM books WHERE title = '#{book_data['title']}'").entries
      elsif book_data['author'] 
        db.exec("SELECT * FROM books WHERE title = '#{book_data['author']}'").entries 
      end
    end

    def self.get_status(db, book_id)
      db.exec("SELECT * FROM books WHERE id = #{book_data['id']}").entries.last['status']
    end

    def self.get_history(db, id)
      if id['book_id']
        db.exec("SELECT * FROM checkouts WHERE book_id = #{id['book_id']}").entries
      elsif id['user_id']
        db.exec("SELECT * FROM checkouts WHERE user_id = #{id['user_id']}").entries
      end
    end

  end
end
