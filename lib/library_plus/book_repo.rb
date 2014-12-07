module Library
  class BookRepo

    def self.all(db)
      db.exec("SELECT * FROM books;").to_a
    end

    def self.save(db, book_data)
      if book_data['id']
        sql = %q[UPDATE books 
          SET title = $1 AND SET author = $2 
          WHERE id = $3 
          RETURNING *;
        ]
        result = db.exec(sql, [book_data['title'], book_data['author'], book_data['id']])
      else 
        sql = %q[INSERT INTO books (title, author) 
          VALUES ($1, $2) 
          RETURNING *;
        ]
        result = db.exec(sql, [book_data['title'], book_data['author']])
      end
      result.first
    end

    def self.status(db, book_id)
      sql = %q[UPDATE books 
          SET status = $1
          WHERE id = $2 
          RETURNING *;
        ]
      book = self.find(db, book_id)
      if book['status'] == 'available'
        result = db.exec(sql, ['checked_out', book_id])
      else 
        result = db.exec(sql, ['available', book_id])
      end
      result.first  
    end

    def self.find(db, book_id)
      result = db.exec("SELECT * FROM books WHERE id = $1;", [book_id])
      result.first
    end

    def self.destroy(db, book_id)
      db.exec("DELETE FROM books WHERE id = $1;", [book_id])
    end

    def self.check_out_book(db, user_id, book_id)
      sql = %q[INSERT INTO checkouts (user_id, book_id) 
          VALUES ($1, $2) 
          RETURNING *;
          ]
      result = db.exec(sql, [user_id, book_id])
      result.first
    end

    def self.check_in_book(db, book_id)
      sql = %q[UPDATE checkouts 
        SET status = 'available'
        WHERE book_id = $1
        RETURNING *;
      ]
      result = db.exec(sql, [book_id])
      result.first
    end

  end
end