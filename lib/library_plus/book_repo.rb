module Library

  class BookRepo 
    
    def self.all(db)
      db.exec('SELECT * FROM books;').to_a
    end
    
    def self.find(db, book_id)
      result = db.exec('SELECT * FROM books WHERE id = ($1)',[book_id])
      result.entries[0]
    end
    
    def self.save(db, book_data)
      book_title = book_data['title']
      book_author = book_data['author']
      book_status = 'available'
      sql = %q[
        INSERT INTO books (title, author, status)
        VALUES ($1,$2,$3)
      ]
      
      db.exec(sql,[book_title,book_author,book_status])
      db.exec('SELECT * FROM books WHERE title = ($1)',[book_title]).entries[0]
    end
    
    def self.check_out(db, book_id, borrower_id)
      book_data = db.exec('SELECT * FROM books WHERE id = ($1)',[book_id]).entries[0]
      book_status = book_data['status']
      if book_status == 'available'
        sql = %q[
          UPDATE books
          SET 
            status = ($1),
            borrower_id = ($2)
          WHERE id = ($3)
        ]
        db.exec(sql,['checked out', borrower_id, book_id])
        result = db.exec('SELECT * FROM books WHERE id = ($1)',[book_id]).entries[0]
        result
      else
        book_data
      end  
    end
    
    def self.check_in(db, book_id)
      sql = %q[
        UPDATE books
        SET
          status = ($1),
          borrower_id = ($2)
        WHERE id = ($3)
      ]
      db.exec(sql,['available', nil, book_id]).entries[0]
      db.exec('SELECT * FROM books WHERE id = ($1)',[book_id]).entries[0]
    end
    
  end

end