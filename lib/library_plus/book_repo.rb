# TODO
module Library
  class BookRepo

    def self.all(db)
      db.exec("select * from books").to_a
    end

    def self.save(db, title, author)
      db.exec("INSERT into books (title, author) values ($1, $2)", [title, author])
    end

    def self.check_out(db, book_id, user_id)
      db.exec("INSERT into checkout (book_id, user_id, status) values ($1, $2, $3)", [book_id, user_id, 'checked out'])
    end

    def self.check_in(book_id)
      db.exec("DELETE FROM checkout WHERE id = #{book_id}")
    end

    def self.all_check_out(db)
      db.exec("SELECT * FROM checkout")
    end

  end
end