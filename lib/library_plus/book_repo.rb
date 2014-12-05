# TODO
module Library
  class BookRepo

    def self.all
      db.exec("SELECT * FROM books").to_a
    end

    def self.check_out(db, book_id)

    end

    def self.find(db, book_id)
       db.exec("select * from books where id = $1",[book_id])[0]
    end

    def self.save(db, book_data)
        if book_data['id']
          db.exec("UPDATE books SET title = $1, author = $2 WHERE id = $3 returning *",[book_data['title'],book_data['author'],book_data['id']])[0]      
        else
          db.exec("INSERT into books (title, author) values ($1, $2) returning *", [book_data['title'], book_data['author']])[0]
        end
    end

    def self.destroy(db, book_id)
       db.exec("DELETE FROM books WHERE id = $1", [book_id])
    end

  end
end

