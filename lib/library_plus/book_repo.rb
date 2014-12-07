module Library

  class BookRepo 
    
    def self.all(db)
      db.exec('SELECT * FROM books;').to_a
    end
    
    def self.find(db, book_id)
      result = db.exec('SELECT title, author, id FROM books WHERE id = ($1)',[book_id])
      result.entries[0]
    end
    
    def self.save(db, book_data)
      sql = %q[
        INSERT INTO books (title, author, status)
        VALUES ($1,$2,$3)
      ]
      book_title = book_data['title']
      book_author = book_data['author']
      book_status = 'available'
      
      db.exec(sql,[book_title,book_author,book_status])
      db.exec('SELECT * FROM books WHERE title = ($1)',[book_title]).entries[0]
    end
    
    
  end

end