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
        status[-1]['status']
      end
    end

    def self.checkout(db, book_id, user_name)
      response = db.exec("SELECT status FROM checkouts where book_id = $1", [book_id]).to_a
      user_id = db.exec("SELECT id FROM users where name = $1", [user_name]).to_a[0]['id']
      if response.entries[0] == nil      
        user_id = db.exec("SELECT id FROM users where name = $1", [user_name]).to_a[0]['id']
        status = db.exec("INSERT INTO checkouts (user_id, book_id, status) VALUES ($1, $2, $3) returning status", [user_id, book_id, "checked_out"]).to_a[0]['status']
        # response = "This book has not been checked out."
        status
      elsif response.entries[0]['status'] == "available" || response.entries[0]['status'] == "returned"
        # former_user_id = ("SELECT user_id from checkouts where book_id = $1", [book_id]).to_a[0]['user_id']
        # if former_user_id
        status = db.exec("INSERT INTO checkouts (user_id, book_id, status) VALUES ($1, $2, $3) returning status", [user_id, book_id, "checked_out"]).to_a[0]['status'] #SET status = $1 WHERE book_id = $2 returning status", ["checked_out", book_id]).to_a[0]['status']
        status
      else
        status = "This book is currently checked out, please select another."
      end
    end

    def self.checkin(db, book_id)
      db.exec("UPDATE checkouts SET status = $1 WHERE book_id = $2", ["returned", book_id])

    end

    def self.checkout_history(db, book_id)
      response = db.exec("select distinct u.name as name, b.title as title from checkouts c join users u on u.id = c.user_id join books b on b.id = c.book_id where c.book_id = $1", [book_id]).to_a
      response
    end

    def self.user_history(db, user_name_id)
    end

# library_dev=# select u.name as users, b.title as books from checkouts c join users u on u.id = c.user_id join books b on b.id = c.book_id;
 

  end
end
