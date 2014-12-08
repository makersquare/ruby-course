# TODO
module Library
  class BookRepo

    def self.all(db)
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_id)
      db.exec("SELECT * FROM books WHERE id = $1", [book_id]).to_a[0]
    end

    def self.get_status(db, book_id)
      db.exec("SELECT status from checkouts where bookid = $1", [book_id]).to_a[0]
    end

    def self.getborrower(db, book_id)
      db.exec("SELECT name from users u join checkouts c on c.userid = u.id join books b on c.bookid = b.id where c.bookid = $1", [book_id]).to_a[0]
    end

    #Libary::UserRepo.save(db, {'id' => "1"})
    def self.save(db, book_data)
      if book_data['id']
        # TODO: Update SQL statement
        db.exec("UPDATE books SET title = $1, author = $2 WHERE id = $3 returning *", [book_data['title'], book_data['author'], book_data['id']]).to_a[0]
      else
        # TODO: Insert SQL statement
        newbook = db.exec("INSERT INTO books (title, author) VALUES ($1, $2) returning *", [book_data['title'], book_data['author']]).to_a[0]
        Library::BookRepo.addtocheckouts(db, newbook['id'])
        end
    end

    def self.addtocheckouts(db, book_id)
      db.exec("INSERT INTO checkouts (bookid, status, time) values ($1, 'available', $2)",[book_id, DateTime.now])
    end

    def self.checkout(db, user_id, book_id)
      @findbook = Library::BookRepo.get_status(db, book_id)
      if  @findbook["status"] == 'available'
        db.exec("UPDATE checkouts SET status = 'checked out', userid = $1, time = $2 where bookid = $3",[user_id, DateTime.now, book_id])
      end
    end

    def self.return(db, book_id)
      db.exec("UPDATE checkouts SET status = 'available', userid = null, time = $1 where bookid = $2", [DateTime.now, book_id])
    end

    def self.destroy(db, user_id)
      # TODO: Delete SQL statement
    end

  end
end

