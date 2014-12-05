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

  end
end
